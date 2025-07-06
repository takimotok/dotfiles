---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config" }

---@type string[]
M.files = {
  ".luacheckrc",
  ".luacheckrc.lua",
  "luacheck.config",
}

return M
