---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "-c" }

---@type string[]
M.files = {
  "phpstan.neon",
  "phpstan.neon.dist",
  "phpstan.dist.neon",
}

return M
