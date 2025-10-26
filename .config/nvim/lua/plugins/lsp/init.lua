return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      "Saghen/blink.cmp",
    },
    config = function()
      -- NOTE: Currently, there's no way to run `ensure_installed` in mason itself.
      -- It seems that there are no plan for it.
      -- @see: https://github.com/mason-org/mason.nvim/pull/1949#pullrequestreview-2853679405
      -- Since the reason above, I implement the installation logic for Formatters, Linters, DAPs and AI related tools.
      -- Note that we can install Language Servers with `ensure_installed` in `mason-lspconfig`.
      local mason_opts = require("plugins.lsp.mason.opts")
      require("mason").setup(mason_opts)
      require("plugins.lsp.mason.ensure_installed").install()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      capabilities = vim.tbl_deep_extend("force", capabilities, has_blink and blink.get_lsp_capabilities() or {})

      -- @see: `:h lsp#vim.lsp.config()`
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- @see: `:h vim.diagnostic.Opts` about its options
      -- @see: `:h diagnostic-defaults` about its default keymaps
      local icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      }

      vim.diagnostic.config({
        severity_sort = true,
        signs = {
          text = icons,
        },
        -- underline = false, -- default: true. Use underline for diagnostics
        -- update_in_insert = true, -- default: false. if `false`, diagnostics are updated on |InsertLeave|
      })

      -- TODO: move away `mason*`. Use `mise` instead.
      -- `copilot` LS is not planned.
      -- @see: https://github.com/mason-org/mason-lspconfig.nvim/issues/617
      require("mason-lspconfig").setup({
        ensure_installed = require("plugins.lsp.mason-lspconfig.ensure_installed"),
      })
    end,
  },
}
