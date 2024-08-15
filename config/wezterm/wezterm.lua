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

-- config.window_background_image = '/home/koinworks/Pictures/Wallpapers/GL06TnhbUAAQ4CU.jpeg'
config.window_background_image = '/home/koinworks/Pictures/Wallpapers/F0LkzpPacAEL-6W.jpeg'
config.window_background_opacity = 1.0
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.04,
  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,
  -- You can adjust the saturation also.
  saturation = 1.0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

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

config.color_scheme = 'Kanagawa (Gogh)'

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
  local cells = {}

  local _, date, _ = wezterm.run_child_process({ "date" });
  date = wezterm.strftime("%a %b %-d %H:%M:%S");

  table.insert(cells, date)

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = string.format('%.0f%%', b.state_of_charge * 100)
    table.insert(cells, bat)
  end

  local ctx = 'N/A'
  local handle = io.popen("kubectl config current-context 2>/dev/null")
  if handle then
    ctx = handle:read("*a"):match("^%s*(.-)%s*$")
    handle:close()
    table.insert(cells, ctx)
  end

  local namespace = 'N/A'
  local handle = io.popen("kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null")
  if handle then
    namespace = handle:read("*a"):match("^%s*(.-)%s*$")
    handle:close()
    table.insert(cells, namespace)
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    '#5b5a54',
    '#44433f',
    '#2d2d2a',
    '#161615',
    '#0b0b0a'
  }

  -- Foreground color for the text across the fade
  local text_fg = '#c0c0c0'

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end);

-- NOTE: most use command from default keybindI have
-- CTRL + tab             -> next tab
-- SUPER + t              -> new tab
-- CTRL + d               -> close pane
-- CTRL + SHIFT + Arrow   -> navigate panes

return config
