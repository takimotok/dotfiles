---@class NvimLintModule
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
}

return M
