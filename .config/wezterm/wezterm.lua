local on = require 'on'
local key_tables = require 'key_tables'
local keys = require 'keys'
local sample = require 'sample'
local font = require 'font'
-- local tab_bar_style = require 'tab_bar_style'
local debug = require 'debug'
local wezterm = require 'wezterm'

local config = {}

config = {
  leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },

  automatically_reload_config = true,

  -- spawn a zsh shell in login mode
  default_prog = { '/usr/local/bin/zsh', '-l' },

  --[[ fonts ]]
  use_ime = font.use_ime,
  font_size = font.font_size,
  font = font.font,
  harfbuzz_features = font.harfbuzz_features,

  -- https://wezfurlong.org/wezterm/colorschemes/index.html
  color_scheme = "iceberg-dark",
  color_scheme_dirs = { '$XDG_CONFIG_HOME/wezterm/colors/' },

  adjust_window_size_when_changing_font_size = false,

  use_dead_keys = false,

  unzoom_on_switch_pane = true,

  keys = keys,
  key_tables = key_tables,

  --[[ appearance ]]
  -- tabs
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  tab_max_width = 25,
  switch_to_last_active_tab_when_closing_tab = true,

  -- tab_bar_style = tab_bar_style,
  colors = {
    ttab_barab_bar = {
      background = "#000000",
      active_tab = {
        -- bg_color = '#2b2042',
        -- fg_color = '#c0c0c0',
        bg_color = '#454545',
        fg_color = '#d3d3d3',
      },
      inactive_tab = {
        bg_color = '#1b1032',
        fg_color = '#808080',
      },
      inactive_tab_edge = '#0d0d0d',
      new_tab = {
        bg_color = '#2b2042',
        fg_color = '#c0c0c0',
      },
    },
  },

  -- panes
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
  },

  -- window
  window_background_opacity = 0.7,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  --[[ scrollback ]]
  scrollback_lines = 5000,

}

return config
