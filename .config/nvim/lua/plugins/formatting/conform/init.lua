local formatters_by_ft = require("plugins.formatting.conform.formatters_by_ft")
local formatters = require("plugins.formatting.conform.formatters")

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = formatters_by_ft,
    formatters = formatters,
  },
  -- opts = function(_, opts)
  --   local config = require("kengo.config.plugins.formatting.conform-nvim")
  --
  --   -- override the default opts with the config
  --   -- due to it automatically set undesired configurations
  --   opts.formatters_by_ft = vim.tbl_deep_extend("force", {}, config.formatters_by_ft)
  --   opts.formatters = vim.tbl_deep_extend("force", {}, config.formatters)
  --
  --   return opts
  -- end,
}
