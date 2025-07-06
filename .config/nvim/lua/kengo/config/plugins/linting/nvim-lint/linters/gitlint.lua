---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config" }

---@type string[]
M.files = {
  ".gitlint",
  ".gitlint.ini",
  "setup.cfg",
  "tox.ini",
  ".gitlint.yaml",
  ".gitlint.yml",
}

return M
