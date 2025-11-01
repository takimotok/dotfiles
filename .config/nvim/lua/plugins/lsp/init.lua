return {
  {
    "neovim/nvim-lspconfig",
    event = "FileType",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      "Saghen/blink.cmp",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      capabilities = vim.tbl_deep_extend("force", capabilities, has_blink and blink.get_lsp_capabilities() or {})

      -- @see: `:h lsp#vim.lsp.config()`
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      local diagnostics_icons = require("util.icons").diagnostics
      local icons = {
        [vim.diagnostic.severity.ERROR] = diagnostics_icons.ERROR,
        [vim.diagnostic.severity.WARN] = diagnostics_icons.WARN,
        [vim.diagnostic.severity.INFO] = diagnostics_icons.INFO,
        [vim.diagnostic.severity.HINT] = diagnostics_icons.HINT,
      }

      -- [[ diacnostic floating info. settings]]
      -- @see: `:h vim.diagnostic.Opts.Float`
      -- e.g.) (fun(diagnostic:vim.Diagnostic,i:integer,total:integer): string
      ---@param d vim.Diagnostic Diagnostics
      ---@param i integer index of the diagnostic being evaluated
      ---@return string
      local diagnostic_prefix = function(d, i, _)
        local source = d.source or ""
        local severity = d.severity or ""

        -- cf.) Neovim's diagnostic system uses numeric constants to represent severity levels internally.
        -- vim.diagnostic.severity.ERROR = 1
        -- vim.diagnostic.severity.WARN = 2
        -- vim.diagnostic.severity.INFO = 3
        -- vim.diagnostic.severity.HINT = 4
        --
        -- e.g.) an icon selectioin logic:
        -- local icons = {
        --   [vim.diagnostic.severity.ERROR] = diagnostics_icons.ERROR,
        --   [vim.diagnostic.severity.WARN] = diagnostics_icons.WARN,
        --   [vim.diagnostic.severity.INFO] = diagnostics_icons.INFO,
        --   [vim.diagnostic.severity.HINT] = diagnostics_icons.HINT,
        -- }
        -- icons[2] = diagnostics_icons.WARN

        return string.format("%s %s. [%s] ", icons[severity] or icons[2], i, source)
      end

      -- @see: `:h vim.diagnostic.Opts.Float`
      -- e.g.) (`fun(diagnostic:vim.Diagnostic): string?`)
      ---@param d vim.Diagnostic Diagnostic
      ---@return string | nil
      local diagnostic_format = function(d)
        local message = d.message

        return string.format("%s", message) or nil
      end

      -- @see: `:h vim.diagnostic.Opts` about its options
      -- @see: `:h diagnostic-defaults` about its default keymaps
      vim.diagnostic.config({
        severity_sort = true,
        signs = {
          text = icons,
        },
        -- underline = false, -- default: true. Use underline for diagnostics
        -- update_in_insert = true, -- default: false. if `false`, diagnostics are updated on |InsertLeave|
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = false,
          header = "",
          prefix = diagnostic_prefix,
          format = diagnostic_format,
          -- e.g.) (fun(diagnostic:vim.Diagnostic,i:integer,total:integer): string, string)
          -- {code}? (`string|integer`) The diagnostic code
          ---@param d vim.Diagnostic
          ---@return string, string
          suffix = function(d, _, _)
            return string.format(" [%s]", d.code or ""), "DiagnosticFloatingDefault"
          end,
        },
      })

      -- TODO: move away `mason*`. Use `mise` instead.
      -- `copilot` LS is not planned.
      -- @see: https://github.com/mason-org/mason-lspconfig.nvim/issues/617
      --
      -- The `mason-lspconfig` plugin has responsibilities for:
      --   - automatically installing Language Servers by `ensure_installed`
      --   - automatically enabling installed servers by executing `vim.lsp.enable()` internally
      require("mason-lspconfig").setup({
        ensure_installed = require("plugins.lsp.mason-lspconfig.ensure_installed"),
      })
    end,
  },
}
