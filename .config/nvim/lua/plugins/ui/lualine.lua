local opts = require("plugins.ui.lualine.opts")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = opts,
  config = function(_, user_opts)
    require("lualine").setup(user_opts)
  end,
}
