local km = require("util.key_mapper")

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufEnter",
  opts = {
    indent = {
      char = "┊",
      tab_char = "┊",
      -- char = "│",
      -- tab_char = "│",
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    -- keymaps
    km.nmap("<leader>ug", ":IBLToggle<CR>", { desc = "Toggles IndentBlankline" })
  end,
}
