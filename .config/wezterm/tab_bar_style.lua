local wezterm = require 'wezterm'

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local module = {
  active_tab_left = wezterm.format {
    { Background = { Color = '#D3F72F' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = SOLID_LEFT_ARROW },
  },
  active_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#2b2042' } },
    { Text = SOLID_RIGHT_ARROW },
  },
  inactive_tab_left = wezterm.format {
    -- { Background = { Color = '#0b0022' } },
    { Background = { Color = '#D3F72F' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = SOLID_LEFT_ARROW },
  },
  inactive_tab_right = wezterm.format {
    { Background = { Color = '#0b0022' } },
    { Foreground = { Color = '#1b1032' } },
    { Text = SOLID_RIGHT_ARROW },
  },
}

return module
