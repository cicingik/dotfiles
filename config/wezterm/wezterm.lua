local wezterm = require 'wezterm'
local mux = wezterm.mux
local session_manager = require 'wezterm-session-manager/session-manager'

wezterm.on("save_session", function(window) session_manager.save_state(window) end)
wezterm.on("load_session", function(window) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)


-- NOTE: most use command from default keybind that I have
-- CTRL + tab             -> next tab
-- SUPER + t              -> new tab
-- CTRL + d               -> close pane
-- CTRL + SHIFT + Arrow   -> navigate panes
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local CURRENTS_WALLPAPER = '/personal/dotfiles/config/wezterm/wallpaper/GLrUaxgbgAAG5Ic.jpeg'

-- Color palette for the backgrounds of each cell
-- ref: https://colorswall.com/palette/228122
local bw_pallete = {
  '#000000',
  '#2e2e2c',
  '#454442',
  '#5c5b58',
  '#73726e',
}
-- ref: https://www.color-hex.com/color-palette/1017579
local kanagawa_wave_pallete = {
  '#515797',
  '#627d9a',
  '#dfc5a4',
  '#babbbd',
  '#fffef7',
}

local black = '#000000'
local white = '#ffffff'

local kube = '󱃾  ' --'🌈'
local battery = '🔥'
local active_workspace = '🌊 '
local motion = { '🌕', '🌖', '🌗', '🌘', '🌑', '🌒', '🌓', '🌔' }

local config = {}
-- Foreground color for the text across the fade
local text_fg = black
local colors = kanagawa_wave_pallete

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local handle = io.popen("echo $HOME")
if handle then
  local home = handle:read("*a"):match("^%s*(.-)%s*$")
  handle:close()
  config.window_background_image = home .. CURRENTS_WALLPAPER
end

config.adjust_window_size_when_changing_font_size = true
config.default_cursor_style = "BlinkingBar"
config.automatically_reload_config = true
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.window_close_confirmation = 'NeverPrompt'

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
  family = 'JetBrains Mono',
  weight = 'Bold',
  stretch = 'Condensed',
})
config.font_size = 11.5
config.freetype_load_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
config.freetype_render_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.switch_to_last_active_tab_when_closing_tab = true

-- Color Scheme
config.window_background_opacity = 1.0
config.color_scheme = 'Kanagawa (Gogh)'
config.switch_to_last_active_tab_when_closing_tab = true

config.window_background_image_hsb = {
  -- Darken the background image
  brightness = 0.2,
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

-- config.default_gui_startup_args = { 'connect', 'unix' }
config.default_workspace = 'development'
-- Setup muxing by default
-- config.unix_domains = {
-- 	{ name = 'unix' },
-- }

wezterm.on("update-right-status", function(window)
  local cells = {}

  -- local interval = wezterm.strftime("%S")
  -- interval = tonumber(interval)
  -- local idx = 0
  -- if interval then
  --   idx = math.fmod(interval, #motion)
  -- end
  -- table.insert(cells, motion[idx + 1])

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = string.format('%.0f%%', b.state_of_charge * 100)
    if b.state == 'Charging' then
      bat = battery .. " " .. bat
    end

    table.insert(cells, bat)
  end

  local _, date, _ = wezterm.run_child_process({ "date" });
  date = wezterm.strftime("%a %b %-d %H:%M:%S");
  table.insert(cells, date)

  local workspace = window:active_workspace()
  table.insert(cells, active_workspace .. workspace)

  local ctx = 'N/A'
  local handle_kcs = io.popen("$HOME/bin/kubectl config current-context")
  if handle_kcs then
    ctx = handle_kcs:read("*a"):match("^%s*(.-)%s*$")
    handle_kcs:close()
  end

  local namespace = 'N/A'
  local handle_ns = io.popen("$HOME/bin/kubectl config view --minify --output 'jsonpath={..namespace}'")
  if handle_ns then
    namespace = handle_ns:read("*a"):match("^%s*(.-)%s*$")
    handle_ns:close()
  end

  table.insert(cells, kube .. ctx .. '   ' .. namespace .. ' ')

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  local function push(text, is_last)
    local cell_no = num_cells + 1
    if cell_no == 1 then
      table.insert(elements, { Foreground = { Color = colors[cell_no] } })
      table.insert(elements, { Text = SOLID_RIGHT_ARROW })
    end

    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_RIGHT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end);

config.disable_default_mouse_bindings = false
config.mouse_bindings = {
  -- Open URLs with Ctrl+Click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  }
}

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'SUPER', timeout_milliseconds = 1000 }
config.keys = {
  -- Pane Configuration
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },

  -- Attach to muxer
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.AttachDomain 'unix',
  },

  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action.DetachDomain { DomainName = 'unix' },
  },

  -- Show list of workspaces
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
  -- Rename current session; analagous to command in tmux
  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },

  -- Session manager bindings
  {
    key = 'w',
    mods = 'LEADER|SHIFT',
    action = wezterm.action({ EmitEvent = "save_session" }),
  },
  {
    key = 'L',
    mods = 'LEADER|SHIFT',
    action = wezterm.action({ EmitEvent = "load_session" }),
  },
  {
    key = 'R',
    mods = 'LEADER|SHIFT',
    action = wezterm.action({ EmitEvent = "restore_session" }),
  },
}

return config
