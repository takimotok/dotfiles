---@class NvimLintModule
local M = {}

---@type string[]
-- @NOTE: 下記または `--standard=/path/to/config_file`
M.opts = { "--config-set", "intalled_paths" }

---@type string[]
M.files = {
  "phpcs.xml",
  ".phpcs.xml",
  "phpcs.xml.dist",
  ".phpcs.xml.dist",
}

return M
