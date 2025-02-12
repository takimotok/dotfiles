require("on")
local font = require("font")
local key_tables = require("key_tables")
local keys = require("keys")
-- require("tab_bar_style")

local config = {}

config = {
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },

  -- cf.) https://wezfurlong.org/wezterm/config/lua/config/term.html?h=term
  -- tempfile=$(mktemp) \
  -- && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  -- && tic -x -o ~/.terminfo $tempfile \
  -- && rm $tempfile
  term = "wezterm",

  use_ime = true,
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",

  automatically_reload_config = true,

  -- spawn a zsh shell in login mode
  default_prog = { "/bin/zsh", "-l" },

  --[[ fonts ]]
  font_size = font.font_size,
  font = font.font,
  font_rules = font.font_rules,
  harfbuzz_features = font.harfbuzz_features,

  -- https://wezfurlong.org/wezterm/colorschemes/index.html
  color_scheme = "iceberg-dark",
  color_scheme_dirs = { "$XDG_CONFIG_HOME/wezterm/colors/" },

  adjust_window_size_when_changing_font_size = false,

  use_dead_keys = false,

  unzoom_on_switch_pane = true,

  keys = keys,
  key_tables = key_tables,

  --[[ mouse ]]
  -- hide_mouse_cursor_when_typing = true,
  disable_default_mouse_bindings = true,

  --[[ appearance ]]
  --
  -- tabs
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  tab_max_width = 25,
  switch_to_last_active_tab_when_closing_tab = true,

  colors = {
    tab_bar = {
      background = "#000000",
      active_tab = {
        bg_color = "#454545",
        fg_color = "#D3D3D3",
      },
      inactive_tab = {
        bg_color = "#1b1032",
        fg_color = "#808080",
      },
      inactive_tab_edge = "none",
      new_tab = {
        bg_color = "#2b2042",
        fg_color = "#c0c0c0",
      },
    },
  },

  show_new_tab_button_in_tab_bar = false,
  show_close_tab_button_in_tabs = false,

  -- panes
  inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
  },

  -- window
  window_background_opacity = 0.8,
  macos_window_background_blur = 20,
  window_decorations = "RESIZE",
  window_background_gradient = {
    colors = { "#000000" },
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  --[[ scrollback ]]
  scrollback_lines = 5000,

  --[[ reflesh rate ]]
  -- Limits the maximum number of frames per second that wezterm will attempt to draw
  max_fps = 200,
}

return config
