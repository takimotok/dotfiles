local configs = require("config.plugins.lsp")
local handlers = require("config.plugins.lsp.handlers")

return {
  -- { "vigoux/ltex-ls.nvim" },
  -- { "barreiroleo/ltex-extra.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      -- "folke/neoconf.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      --[[
        cf.) https://github.com/folke/neoconf.nvim#-setup
        > It's important that you set up neoconf.nvim BEFORE nvim-lspconfig.

        cf.) https://github.com/williamboman/mason-lspconfig.nvim#setup
        > It's important that you set up the plugins in the following order:
        > 1. mason.nvim
        > 2. mason-lspconfig.nvim
        > 3. Setup servers via lspconfig
      ]]
      -- require("neoconf").setup()
      require("mason").setup()

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = configs.ensure_installed,
        handlers = handlers.setup(),
      })
      configs.setup()
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = { "LspAttach" },
    opts = function()
      return {
        autocmd = {
          enabled = false,
          events = { "CursorHold", "CursorHoldI" },
          pattern = { "*" },
        },
        sign = { enabled = false },
        virtual_text = { enabled = true },
        ignore = {
          ft = { "markdown" },
        },
      }
    end,
  },
}
