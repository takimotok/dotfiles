local opts = require("plugins.formatting.conform.opts")

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = opts,
}
