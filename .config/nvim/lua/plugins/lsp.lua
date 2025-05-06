local config_mason = require("kengo.config.plugins.lsp.mason")
config_mason.init()

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = config_mason.ensure_installed,
    },
  },
}
