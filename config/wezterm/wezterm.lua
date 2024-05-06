local wezterm = require 'wezterm'

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 10
config.adjust_window_size_when_changing_font_size = true

config.window_background_image = '/home/koinworks/Pictures/Wallpapers/GL06TnhbUAAQ4CU.jpeg'
config.window_background_opacity = 1.0
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.02,
  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,
  -- You can adjust the saturation also.
  saturation = 1.0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

config.default_cursor_style = "BlinkingBar"

config.colors = {
  foreground = "#dcd7ba",
  background = "#1f1f28",

  cursor_bg = "#c8c093",
  cursor_fg = "#c8c093",
  cursor_border = "#c8c093",

  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",

  scrollbar_thumb = "#16161d",
  split = "#16161d",

  ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
  brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
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
}

wezterm.on("update-right-status", function(window)
  -- demonstrates shelling out to get some external status.
  -- wezterm will parse escape sequences output by the
  -- child process and include them in the status area, too.
  local _, date, _ = wezterm.run_child_process({ "date" });

  -- However, if all you need is to format the date/time, then:
  date = wezterm.strftime("%a %b %-d %H:%M:%S");

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
  end


  -- Make it italic and underlined
  window:set_right_status(wezterm.format({
    { Text = bat .. ' | ' .. date .. ' | ' .. "kube_ctx" },
  }));
end);

-- NOTE: most use command from default keybind
-- CTRL + tab             -> next tab
-- SUPER + t              -> new tab
-- CTRL + d               -> close pane
-- CTRL + SHIFT + Arrow   -> navigate panes

return config
