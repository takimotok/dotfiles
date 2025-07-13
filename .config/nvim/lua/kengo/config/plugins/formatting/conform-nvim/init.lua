local formatters_by_ft = require("kengo.config.plugins.formatting.conform-nvim.formatters_by_ft")
local formatters = require("kengo.config.plugins.formatting.conform-nvim.formatters")

---@class Formatting
local M = {}

M.formatters_by_ft = formatters_by_ft
M.formatters = formatters.setup()

return M
