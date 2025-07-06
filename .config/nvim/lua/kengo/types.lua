---@module "kengo.types"

-- for COMMON
---@alias FiletypeName string file type name
---@alias ConfigFileName string config file name
---@alias FormatterName string formatter name
---@alias LinterName string linter name

-- for LSP diagnostics
---@class DiagnosticConfig
---@field virtual_text boolean|table virtual textの設定
---@field signs table サイン設定
---@field underline boolean 下線表示
---@field update_in_insert boolean 挿入モード中の更新
---@field severity_sort boolean 重要度でソート
---@field float table フロートウィンドウ設定

-- for nvim-lint
---@class NvimLintModule
-- @field linters_by_ft table<FiletypeName, LinterName[]>
-- @field linters table<string,lint.Linter|fun():lint.Linter>
---@field opts string
---@field files table<string>

-- for conform.nvim
---@class ConformModule
---@field formatters_by_ft table<FiletypeName, FormatterName[]>
---@field formatters table<FormatterName, conform.FormatterConfig>
