local config = require("config.plugins.nvim-lint")

return {
  "mfussenegger/nvim-lint",
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    config.setLinters()
    config.setTriggers()
  end,
}
