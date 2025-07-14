---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config" }

---@type string[]
M.files = {
  ".shellcheckrc",
}

return M
