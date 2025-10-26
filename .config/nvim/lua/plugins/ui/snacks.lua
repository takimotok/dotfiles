local keys = require("plugins.ui.snacks.keys")
local opts = require("plugins.ui.snacks.opts")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = keys,
  opts = opts,
}
