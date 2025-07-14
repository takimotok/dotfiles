---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config" }

-- sqlfluff の設定ファイル名（優先順位順）
---@type string[]
M.files = {
  ".sqlfluff",
  "setup.cfg",
  "tox.ini",
  "pyproject.toml",
}

return M
