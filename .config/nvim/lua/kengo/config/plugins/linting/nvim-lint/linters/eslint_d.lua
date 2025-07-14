---@class NvimLintModule
local M = {}

---@type string[]
M.opts = { "--config" }

---@type string[]
M.files = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
  "package.json",
}

return M
