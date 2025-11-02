local M = {}

M.formatters_by_ft = require("plugins.formatting.conform.formatters_by_ft")

-- M.formatters = { "injected" }

M.default_format_opts = {
  timeout_ms = 500,
  lsp_format = "fallback",
}

M.format_on_save = nil

M.format_after_save = {
  async = true,
}

M.log_level = vim.log.levels.WARN

return M
