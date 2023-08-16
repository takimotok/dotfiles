local M = {}

M.servers = {
  "awk_ls",
  "bashls",
  "denols",
  "eslint",
  "jsonls",
  "lua_ls",
  "marksman",
  "phpactor",
  "pyright",
  "ruff_lsp",
  "sqlls",
  "stylelint_lsp",
  "tailwindcss",
  "tsserver",
  "yamlls",
}

local function setup()
  local signs = {
    Error = "",
    Warn = "⚠️",
    Info = "󰙎",
    Hint = "💡",
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = hl,
    })
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  })
end

function M.setup()
  setup()
end

return M
