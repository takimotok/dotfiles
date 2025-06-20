local config = require("kengo.config.plugins.formatting.conform-nvim")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = config.formatters_by_ft,
      formatters = config.formatters,
    },
  },
}
