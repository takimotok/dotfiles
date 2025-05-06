km = require("kengo.core.key_mapper")

return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
      },
    },
  },
  {
    "Saghen/blink.compat",
  },
  {
    "godlygeek/tabular",
    fg = { "csv" },
    config = function()
      -- keymaps
      km.nmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
      km.xmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
    end,
  },
}
