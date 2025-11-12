return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true, -- Enable this to disable setting the background color
    styles = {
      functions = { italic = true },
      sidebars = "transparent", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
    on_highlights = function(hl, c)
      hl.WinSeparator = {
        -- @see: https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
        fg = c.bg_visual,
      }
    end,
  },
  config = function(_, user_opts)
    require("tokyonight").setup(user_opts)

    vim.cmd([[colorscheme tokyonight]])
  end,
}
