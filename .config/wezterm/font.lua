local wezterm = require("wezterm")

-- local font_name = "Iosevka Nerd Font Mono"
-- local font_name = "Hack Nerd Font Mono"
-- local font_name = "PlemolJP Console NF"
local font_name = "HackGen Console NF"

local M = {
  use_ime = true,
  font_size = 13.0,
  font = wezterm.font_with_fallback({
    {
      family = font_name,
      weight = "Regular",
    },
    {
      family = "PlemolJP Console NF",
      weight = "Regular",
    },
    {
      family = "Sarasa Mono J Nerd Font",
      weight = "Regular",
    },
    {
      family = "Noto Color Emoji",
      weight = "Regular",
    },
  }),
  font_rules = {
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font({
        family = font_name,
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font({
        family = "Victor Mono",
        weight = "Bold",
        style = "Italic",
      }),
    },
    {
      italic = true,
      intensity = "Half",
      font = wezterm.font({
        family = "Victor Mono",
        weight = "DemiBold",
        style = "Italic",
      }),
    },
  },
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}

return M
