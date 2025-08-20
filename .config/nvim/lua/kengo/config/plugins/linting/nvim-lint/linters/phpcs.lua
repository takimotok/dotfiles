---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--standard=" }

---@type string[]
M.files = {
  "phpcs.xml",
  ".phpcs.xml",
  "phpcs.xml.dist",
  ".phpcs.xml.dist",
}

return M
