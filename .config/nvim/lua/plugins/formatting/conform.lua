-- local formatters_by_ft = require("plugins.formatting.conform.formatters_by_ft")
-- local formatters = require("plugins.formatting.conform.formatters")
--
local opts = require("plugins.formatting.conform.opts")

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = opts,
}
