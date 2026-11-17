local wezterm = require("wezterm")

local mux = wezterm.mux
local session_manager = require("wezterm-session-manager/session-manager")
local claude_usage = require("claude_usage")

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- NOTE: most use command from default keybind that I have
-- CTRL + tab             -> next tab
-- SUPER + t              -> new tab
-- CTRL + d               -> close pane
-- CTRL + SHIFT + Arrow   -> navigate panes
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This is where you actually apply your config choices.
local XDG_CONFIG_DIR = "$HOME/.config"
-- local CURRENTS_WALLPAPER = "/wezterm/wallpaper/GMezaAQbIAALZEl.jpeg"
local CURRENTS_WALLPAPER = "/wezterm/wallpaper/GZCYVN9acAACfwu.jpeg"
config.window_background_image = XDG_CONFIG_DIR .. CURRENTS_WALLPAPER

-- Color palette for the backgrounds of each cell
-- ref: https://colorswall.com/palette/228122
-- local bw_pallete = {
-- 	"#000000",
-- 	"#2e2e2c",
-- 	"#454442",
-- 	"#5c5b58",
-- 	"#73726e",
-- 	"#9f9e9e",
-- 	"#b0aeae",
-- 	"#bfbcbc",
-- 	"#d4d3d3",
-- 	"#e7e3e3",
-- }
-- ref: https://www.color-hex.com/color-palette/1017579
local kanagawa_wave_pallete = {
	"#515797",
	"#627d9a",
	"#dfc5a4",
	"#babbbd",
	"#fffef7",
}

local black = "#000000"
-- local white = "#ffffff"

local kube = "󱃾  " --'🌈'
local battery = "🔋"
local charging = "⚡"
local active_workspace = "🌊 "
-- local motion = { "🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔" }
local motion = { "🔥", "🧨", "💥", "✨", "🔥" }

-- Foreground color for the text across the fade
local text_fg = black
local colors = kanagawa_wave_pallete

-- local handle = io.popen("echo $HOME")

config.adjust_window_size_when_changing_font_size = true
config.default_cursor_style = "BlinkingBar"
config.automatically_reload_config = true
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.window_close_confirmation = "NeverPrompt"

-- Colour
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = black,

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = colors[2],
			-- The color of the text for the tab
			fg_color = text_fg,
		},
	},
}

-- Font
config.font = wezterm.font({
	family = "JetBrains Mono",
	-- weight = 'Bold',
	stretch = "Condensed",
})
config.font_size = 9
config.freetype_load_target = "Normal" ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
config.freetype_render_target = "Normal" ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.switch_to_last_active_tab_when_closing_tab = true

-- Color Scheme
config.window_background_opacity = 1.0
config.color_scheme = "Kanagawa (Gogh)"
config.switch_to_last_active_tab_when_closing_tab = true

config.window_background_image_hsb = {
	-- Darken the background image
	brightness = 0.1,
	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,
	-- You can adjust the saturation also.
	saturation = 1.0,
}

-- Window config
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.6,
}

config.default_workspace = "development"
-- Persistent sessions (tmux-like): the GUI attaches to a background
-- wezterm-mux-server. Closing/crashing the GUI keeps tabs, panes and running
-- processes alive; reopening WezTerm re-attaches to them.
config.unix_domains = {
	{ name = "unix" },
}
config.default_gui_startup_args = { "connect", "unix" }

config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Ubuntu-24.04",

		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.
		distribution = "Ubuntu-24.04",

		-- The username to use when spawning commands in the distribution.
		-- If omitted, the default user for that distribution will be used.

		-- username = "hunter",

		-- The current working directory to use when spawning commands, if
		-- the SpawnCommand doesn't otherwise specify the directory.

		default_cwd = "$HOME",

		-- The default command to run, if the SpawnCommand doesn't otherwise
		-- override it.  Note that you may prefer to use `chsh` to set the
		-- default shell for your user inside WSL to avoid needing to
		-- specify it here

		-- default_prog = {"fish"}
	},
}
config.default_domain = "WSL:Ubuntu-24.04"

-- A GUI attached to the mux sends new tabs to the server's domain 0, the
-- Windows "local" domain, so make that domain launch WSL. The server's WSL
-- domain can't honor a Linux cwd (Windows checks and drops the path), so the
-- cwd travels as a `wsl.exe --cd` argument instead. wezterm.gui is nil only
-- inside wezterm-mux-server.
local WSL_DISTRO = "Ubuntu-24.04"
local function wsl_args(cwd)
	return { "wsl.exe", "--distribution", WSL_DISTRO, "--cd", cwd or "~" }
end
if not wezterm.gui then
	config.default_prog = wsl_args()
end

-- Linux path of a pane's cwd (from OSC 7), or nil if the shell hasn't reported one.
local function pane_cwd(pane)
	local url = pane:get_current_working_dir()
	if not url then
		return nil
	end
	if type(url) == "userdata" then
		return url.file_path
	end
	return (tostring(url):gsub("^file://[^/]*", ""))
end

local function spawn_wsl_tab()
	return wezterm.action_callback(function(window, pane)
		window:perform_action(wezterm.action.SpawnCommandInNewTab({ args = wsl_args(pane_cwd(pane)) }), pane)
	end)
end

local function split_wsl(direction)
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			wezterm.action.SplitPane({ direction = direction, command = { args = wsl_args(pane_cwd(pane)) } }),
			pane
		)
	end)
end

wezterm.on("update-right-status", function(window)
	local cells = {}

	local interval = wezterm.strftime("%S")
	interval = tonumber(interval)
	local idx = 0
	if interval then
		idx = math.fmod(interval, #motion)
	end
	table.insert(cells, motion[idx + 1])

	-- Claude usage bars
	for _, c in ipairs(claude_usage.cells()) do
		table.insert(cells, c)
	end

	-- local ctx = "N/A"
	-- local handle_kcs = io.popen('wsl.exe -d Ubuntu-24.04 -- bash -lc "kubectl config current-context config current-context"')
	-- if handle_kcs then
	-- 	ctx = handle_kcs:read("*a"):match("^%s*(.-)%s*$")
	-- 	handle_kcs:close()
	-- end

	-- local namespace = "N/A"
	-- local handle_ns = io.popen("/usr/local/bin/kubectl config view --minify --output 'jsonpath={..namespace}'")
	-- if handle_ns then
	-- 	namespace = handle_ns:read("*a"):match("^%s*(.-)%s*$")
	-- 	handle_ns:close()
	-- end

	local pane = window:active_pane()
	local vars = pane:get_user_vars()

	-- user vars can be nil (e.g. right after attaching to the mux server)
	local ctx, namespace = vars.K8S_CTX or "-", vars.K8S_NS or "-"
	table.insert(cells, kube .. ctx .. "   " .. namespace .. " ")

	local date = wezterm.strftime("%a %b %-d %H:%M:%S")
	table.insert(cells, date)

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = string.format("%.0f%%", b.state_of_charge * 100)
		if b.state == "Charging" then
			bat = charging .. battery .. bat
		else
			bat = battery .. bat
		end

		table.insert(cells, bat)
	end

	-- local workspace = window:active_workspace()
	table.insert(cells, active_workspace)

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	local function color_at(n)
		return colors[(n - 1) % #colors + 1]
	end

	local function push(text, is_last)
		local cell_no = num_cells + 1
		if cell_no == 1 then
			table.insert(elements, { Foreground = { Color = color_at(cell_no) } })
			table.insert(elements, { Text = SOLID_RIGHT_ARROW })
		end

		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = color_at(cell_no) } })
		-- table.insert(elements, { Text = " " .. text .. " " })
		if type(text) == "function" then
			-- rich cell (e.g. Claude usage bar): renders its own elements
			table.insert(elements, { Text = " " })
			for _, e in ipairs(text(color_at(cell_no), text_fg)) do
				table.insert(elements, e)
			end
			table.insert(elements, { Text = " " })
		else
			table.insert(elements, { Text = " " .. text .. " " })
		end
		if not is_last then
			table.insert(elements, { Foreground = { Color = color_at(cell_no + 1) } })
			table.insert(elements, { Text = SOLID_RIGHT_ARROW })
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

config.disable_default_mouse_bindings = false
config.mouse_bindings = {
	-- Open URLs with Ctrl+Click
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- timeout_milliseconds defaults to 1000 and can be omitted
config.disable_default_key_bindings = false
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

local act = wezterm.action
config.keys = {
	-- Pane Configuration
	{ key = "t", mods = "LEADER", action = spawn_wsl_tab() },
	{ key = "\\", mods = "LEADER", action = split_wsl("Right") },
	{ key = "-", mods = "LEADER", action = split_wsl("Down") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) },
	-- Detach this window from the mux server (sessions keep running, like tmux detach)
	{ key = "d", mods = "LEADER", action = act.DetachDomain({ DomainName = "unix" }) },
	-- Force-refresh Claude usage in the status bar
	{
		key = "u",
		mods = "LEADER",
		action = wezterm.action_callback(function()
			claude_usage.invalidate()
		end),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},

	-- Session manager bindings
	-- {
	-- 	key = "s",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action({ EmitEvent = "save_session" }),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action({ EmitEvent = "load_session" }),
	-- },
	-- {
	-- 	key = "r",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action({ EmitEvent = "restore_session" }),
	-- },
}

return config
