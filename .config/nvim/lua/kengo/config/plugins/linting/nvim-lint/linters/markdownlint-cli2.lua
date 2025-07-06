---@class NvimLintModule
-- ---@field config_opt string 説明 NvimLintModule
-- ---@field config_files string[] 設定ファイル名
local M = {}

---@type string[]
M.opts = { "--config" }

-- markdownlint-cli2 config file names (in order of precedence)
---@type string[]
M.files = {
  ".markdownlint-cli2.jsonc",
  ".markdownlint-cli2.yaml",
  ".markdownlint-cli2.cjs",
  ".markdownlint-cli2.mjs",
  ".markdownlint.jsonc",
  ".markdownlint.json",
  ".markdownlint.yaml",
  ".markdownlint.yml",
  ".markdownlint.cjs",
  ".markdownlint.mjs",
  "package.json", -- markdownlint設定が含まれる場合
}

return M
