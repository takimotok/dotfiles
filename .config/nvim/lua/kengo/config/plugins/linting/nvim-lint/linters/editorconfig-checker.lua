---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "-config" }

---@type string[]
M.files = {
  ".editorconfig",
}

return M
