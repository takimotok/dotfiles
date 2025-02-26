local wezterm = require("wezterm")

-- local font_name = "Iosevka Nerd Font Mono"
-- local font_name = "Hack Nerd Font Mono"
-- local font_name = "PlemolJP Console NF"
-- local font_name = "HackGen Console NF"
local font_name = "Ligalex Mono"

local M = {
  font_size = 12.0,
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
        weight = "ExtraBold",
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
  harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
}

return M
