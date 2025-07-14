local config_linters_by_ft = require("kengo.config.plugins.linting.nvim-lint.linters_by_ft")
local config_linters = require("kengo.config.plugins.linting.nvim-lint.linters")

---@class Linting メインのnvim-lint設定モジュール
local M = {}
M.linters_by_ft = config_linters_by_ft.linters_by_ft
M.linters = config_linters

return M
