local opts = require("plugins.ui.snacks.opts")
local keys = require("plugins.ui.snacks.keys")

-- debug start
-- vim.notify("keys= " .. vim.inspect(keys))
-- debug end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = opts,
  keys = keys,
}

