local config_mason = require("kengo.config.plugins.lsp.mason")
config_mason.init()

local config_nvim_lspconfig = require("kengo.config.plugins.lsp.nvim-lspconfig")

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = config_mason.ensure_installed,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = config_nvim_lspconfig.opts,
  },
}
