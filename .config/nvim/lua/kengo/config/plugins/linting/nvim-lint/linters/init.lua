require("kengo.types")

local utils = require("kengo.config.plugins.linting.nvim-lint.utils")

---@class LintersModule linter 設定モジュール
---@field linters table<LinterName, lint.Linter|fun():lint.Linter> M.linters を独自にカスタマイズしたもの
local M = {}

---@type table<LinterName, lint.Linter|fun():lint.Linter>
M.linters = utils.setup_linters()

return M
