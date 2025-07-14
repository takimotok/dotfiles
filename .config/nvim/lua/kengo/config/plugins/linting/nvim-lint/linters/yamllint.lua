---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config-file" }

-- yamllint の設定ファイル名（優先順位順）
---@type string[]
M.files = {
  ".yamllint",
  ".yamllint.yml",
  ".yamllint.yaml",
}

return M
