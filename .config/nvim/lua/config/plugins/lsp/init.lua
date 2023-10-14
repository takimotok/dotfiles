local M = {}

M.ensure_installed = {
  "awk_ls",
  "bashls",
  "denols",
  "eslint",
  "jsonls",
  "ltex",
  "lua_ls",
  "marksman",
  "phpactor",
  "pyright",
  "ruff_lsp",
  "rust_analyzer",
  "sqlls",
  "stylelint_lsp",
  "tailwindcss",
  "tsserver",
  "volar",
  "yamlls",
  "zk",
}

local function setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "⚠️" },
    { name = "DiagnosticSignHint", text = "💡" },
    { name = "DiagnosticSignInfo", text = "󰙎" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      text = sign.text,
      texthl = sign.name,
      numhl = sign.name,
    })
  end

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --   virtual_text = false,
  --   update_in_insert = false,
  --   float = {
  --     border = "rounded",
  --     header = "",
  --     prefix = "",
  --     source = "always",
  --     format = function(diagnostic)
  --       return string.format("%s: [%s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
  --     end,
  --   },
  -- })

  local config = {
    virtual_text = false,
    update_in_insert = false,
    signs = {
      active = signs,
    },
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      -- source = "always",
      header = "",
      prefix = "",
      format = function(diagnostic)
        -- return string.format("%s: [%s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
        return string.format("[%s]: %s", diagnostic.source, diagnostic.message)
      end,
    },
  }
  vim.diagnostic.config(config)
end

function M.setup()
  setup()
end

return M
