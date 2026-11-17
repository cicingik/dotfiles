-- Claude plan usage (5h session + 7d weekly) for the WezTerm status bar.
-- Reads the OAuth token from Claude Code's credentials file inside WSL and
-- queries https://api.anthropic.com/api/oauth/usage, caching the result so the
-- network call only happens every REFRESH_SECONDS (update-right-status fires
-- every second).
local wezterm = require("wezterm")

local M = {}

M.CREDENTIALS_PATH = [[\\wsl.localhost\Ubuntu-24.04\$HOME\.claude\.credentials.json]]
M.REFRESH_SECONDS = 180 -- success refresh interval
M.RETRY_SECONDS = 60 -- retry interval after an error
M.BAR_WIDTH = 8
M.SHOW_BAR = false -- true: draw a usage bar; false: percentage only

M.colors = {
	ok = "#98bb6c", -- green
	warn = "#e6c384", -- yellow
	crit = "#e46876", -- red
	empty = "#454442",
	label = "#7e9cd8",
	dim = "#727169",
}

-- ---------------------------------------------------------------- helpers

local function read_token()
	local f = io.open(M.CREDENTIALS_PATH, "r")
	if not f then
		return nil, "no creds"
	end
	local raw = f:read("*a")
	f:close()
	local ok, data = pcall(wezterm.json_parse, raw)
	if not ok or not data or not data.claudeAiOauth then
		return nil, "bad creds"
	end
	local oauth = data.claudeAiOauth
	if oauth.expiresAt and oauth.expiresAt / 1000 < os.time() then
		return nil, "token expired"
	end
	return oauth.accessToken
end

-- days since 1970-01-01 for a civil (proleptic Gregorian) date, UTC
local function days_from_civil(y, m, d)
	y = (m <= 2) and (y - 1) or y
	local era = math.floor(y / 400)
	local yoe = y - era * 400
	local mp = (m + 9) % 12
	local doy = math.floor((153 * mp + 2) / 5) + d - 1
	local doe = yoe * 365 + math.floor(yoe / 4) - math.floor(yoe / 100) + doy
	return era * 146097 + doe - 719468
end

-- "2026-11-21T22:00:00.463506+00:00" -> unix epoch (UTC)
local function parse_iso(s)
	if type(s) ~= "string" then
		return nil
	end
	local y, mo, d, h, mi, se = s:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
	if not y then
		return nil
	end
	local t = days_from_civil(tonumber(y), tonumber(mo), tonumber(d)) * 86400
		+ tonumber(h) * 3600
		+ tonumber(mi) * 60
		+ tonumber(se)
	local sign, oh, om = s:match("([+-])(%d%d):?(%d%d)$")
	if sign then
		local off = tonumber(oh) * 3600 + tonumber(om) * 60
		t = (sign == "+") and (t - off) or (t + off)
	end
	return t
end

local function fmt_remaining(secs)
	if secs <= 0 then
		return "now"
	end
	local d = math.floor(secs / 86400)
	local h = math.floor((secs % 86400) / 3600)
	local m = math.floor((secs % 3600) / 60)
	if d > 0 then
		return string.format("%dd%dh", d, h)
	elseif h > 0 then
		return string.format("%dh%02dm", h, m)
	end
	return string.format("%dm", m)
end

local function fetch()
	local token, err = read_token()
	if not token then
		return nil, err
	end
	local ok, stdout = wezterm.run_child_process({
		"curl.exe",
		"-s",
		"--max-time",
		"4",
		"-H",
		"Authorization: Bearer " .. token,
		"-H",
		"anthropic-beta: oauth-2025-04-20",
		"-H",
		"Content-Type: application/json",
		"https://api.anthropic.com/api/oauth/usage",
	})
	if not ok or not stdout or stdout == "" then
		return nil, "offline"
	end
	local pok, data = pcall(wezterm.json_parse, stdout)
	if not pok or type(data) ~= "table" then
		return nil, "bad response"
	end
	if data.error then
		return nil, (data.error.type or "api error")
	end
	local function window(w)
		if type(w) ~= "table" or w.utilization == nil then
			return nil
		end
		return { pct = tonumber(w.utilization) or 0, resets_at = parse_iso(w.resets_at) }
	end
	return {
		five_hour = window(data.five_hour),
		seven_day = window(data.seven_day),
	}
end

-- Returns cached usage, refreshing when stale. State lives in wezterm.GLOBAL so
-- it survives config reloads.
local function get_usage()
	local now = os.time()
	local cache = wezterm.GLOBAL.claude_usage or {}
	local interval = cache.err and M.RETRY_SECONDS or M.REFRESH_SECONDS
	if cache.fetched_at == nil or now - cache.fetched_at >= interval then
		local data, err = fetch()
		if data then
			cache = { fetched_at = now, data = data }
		else
			-- keep last good data, remember the error
			cache = { fetched_at = now, data = cache.data, err = err }
		end
		wezterm.GLOBAL.claude_usage = cache
	end
	return cache
end

local function severity_color(pct)
	if pct >= 80 then
		return M.colors.crit
	elseif pct >= 50 then
		return M.colors.warn
	end
	return M.colors.ok
end

local function bar_elements(label, w, now)
	local pct, remaining = 0, nil
	if w then
		pct = w.pct
		if w.resets_at then
			remaining = w.resets_at - now
			-- window already rolled over: usage is effectively reset
			if remaining <= 0 then
				pct, remaining = 0, nil
			end
		end
	end
	pct = math.max(0, math.min(100, pct))
	local filled = math.floor(pct / 100 * M.BAR_WIDTH + 0.5)
	local color = severity_color(pct)
	local els = {
		{ Foreground = { Color = M.colors.label } },
		{ Text = label .. " " },
		{ Foreground = { Color = color } },
		{ Text = string.rep("█", filled) },
		{ Foreground = { Color = M.colors.empty } },
		{ Text = string.rep("░", M.BAR_WIDTH - filled) },
		{ Foreground = { Color = color } },
		{ Text = string.format(" %3d%%", math.floor(pct + 0.5)) },
	}
	if remaining then
		table.insert(els, { Foreground = { Color = M.colors.dim } })
		table.insert(els, { Text = " ↻ " .. " " .. fmt_remaining(remaining) })
	end
	return els
end

-- ---------------------------------------------------------------- public

-- Format elements for wezterm.format(); bg is the cell background color.
function M.elements(bg)
	local now = os.time()
	local cache = get_usage()
	local out = { { Background = { Color = bg } }, { Text = " " } }
	local function add(list)
		for _, e in ipairs(list) do
			table.insert(out, e)
		end
	end

	add({ { Foreground = { Color = "#d27e99" } }, { Text = "✻ " } })

	if not cache.data then
		add({ { Foreground = { Color = M.colors.crit } }, { Text = "claude: " .. (cache.err or "…") .. " " } })
		return out
	end

	add(bar_elements("5h", cache.data.five_hour, now))
	add({ { Foreground = { Color = M.colors.dim } }, { Text = "  │  " } })
	add(bar_elements("7d", cache.data.seven_day, now))
	if cache.err then
		-- stale data marker
		add({ { Foreground = { Color = M.colors.warn } }, { Text = " ⚠" } })
	end
	add({ { Text = " " } })
	return out
end

-- Relative luminance (0..1) of a "#rrggbb" color.
local function luminance(hex)
	local r, g, b = hex:match("#(%x%x)(%x%x)(%x%x)")
	if not r then
		return 0
	end
	local function ch(v)
		v = tonumber(v, 16) / 255
		return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
	end
	return 0.2126 * ch(r) + 0.7152 * ch(g) + 0.0722 * ch(b)
end

-- Bar colors that contrast with the cell background.
local function bar_palette(bg, pct)
	if luminance(bg) < 0.35 then
		-- dark/mid background: bright fill, deep track
		local fill = "#fff3c4"
		if pct >= 80 then
			fill = "#ff8a8a"
		elseif pct >= 50 then
			fill = "#ffd75f"
		end
		return fill, "#1f1f28"
	end
	-- light background: dark fill, pale track
	local fill = "#16161d"
	if pct >= 80 then
		fill = "#c34043"
	elseif pct >= 50 then
		fill = "#b0751a"
	end
	return fill, "#ffffff"
end

-- Cells for the powerline status chain. Each cell is a function(bg, fg)
-- returning format elements, so the bar can contrast with whatever
-- background the chain assigns it.
function M.cells()
	local now = os.time()
	local cache = get_usage()
	if not cache.data then
		return { "✻ claude: " .. (cache.err or "…") }
	end
	local function cell(prefix, label, w, suffix)
		local pct, remaining = 0, nil
		if w then
			pct = w.pct
			if w.resets_at then
				remaining = w.resets_at - now
				if remaining <= 0 then
					pct, remaining = 0, nil
				end
			end
		end
		pct = math.max(0, math.min(100, pct))
		local filled = math.floor(pct / 100 * M.BAR_WIDTH + 0.5)
		local tail = string.format(" %d%%", math.floor(pct + 0.5))
		if pct >= 80 then
			tail = tail .. " !"
		end
		if remaining then
			tail = tail .. " ↻ " .. fmt_remaining(remaining)
		end
		tail = tail .. suffix
		return function(bg, fg)
			if not M.SHOW_BAR then
				return {
					{ Foreground = { Color = fg } },
					{ Text = prefix .. label .. tail },
				}
			end
			local fill, track = bar_palette(bg, pct)
			return {
				{ Foreground = { Color = fg } },
				{ Text = prefix .. label .. " " },
				{ Foreground = { Color = fill } },
				{ Text = string.rep("█", filled) },
				{ Foreground = { Color = track } },
				{ Text = string.rep("█", M.BAR_WIDTH - filled) },
				{ Foreground = { Color = fg } },
				{ Text = tail },
			}
		end
	end
	local stale = cache.err and " ⚠" or ""
	return {
		cell("", "5h", cache.data.five_hour, ""),
		cell("", "7d", cache.data.seven_day, stale),
	}
end

-- Force a refresh on next status update.
function M.invalidate()
	wezterm.GLOBAL.claude_usage = nil
end

return M
