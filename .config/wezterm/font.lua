local wezterm = require 'wezterm'

-- local font_name = 'SauceCodePro Nerd Font Mono'
local font_name = 'Iosevka Nerd Font'

local module = {
  use_ime = true,
  font_size = 14.0,
  font = wezterm.font_with_fallback {
    {
      family = font_name,
      weight = 'Regular',
    },
    {
      family = 'Sarasa Mono J Nerd Font',
      weight = 'Regular',
    },
    {
      family = 'Noto Color Emoji',
      weight = 'Regular',
    },
  },
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

return module
