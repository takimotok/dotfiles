local M = {}

M.ensure_installed = {
  "awk_ls",
  "biome",
  "bashls",
  "eslint",
  "jsonls",
  "ltex",
  "lua_ls",
  "marksman",
  "phpactor@2022.11.12", -- for php7.x
  -- "intelephense",
  "pyright",
  "ruff_lsp",
  "rust_analyzer",
  -- "sqlls",
  "sqls",
  "stylelint_lsp",
  "tailwindcss",
  "tsserver",
  "volar",
  "yamlls",
  "zk",
}

local function setup_diagnostic()
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
        return string.format("[%s]: %s", diagnostic.source, diagnostic.message)
      end,
    },
  }
  vim.diagnostic.config(config)
end

function M.setup()
  setup_diagnostic()
end

return M
