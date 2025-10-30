local M = {}

M.formatters_by_ft = require("plugins.formatting.conform.formatters_by_ft")

M.format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true, -- LSP formatting is used when no other formatters are available
}

return M
