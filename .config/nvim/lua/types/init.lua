---@module "kengo.types"

-- The `kengo.` prefix indicates as user defined anottations

-- -----
-- COMMON
-- -----
---@alias kengo.Filetype string file type
---@alias kengo.ConfigFileName string config file name
---@alias kengo.FormatterName string formatter name
---@alias kengo.LinterName string linter name

---@class (exact) kengo.Context
---@field buf integer
---@field filename string
---@field dirname string

-- -----
-- LSP
-- -----
---@class (exact) kengo.DiagnosticConfig
---@field virtual_text boolean|table virtual text settings
---@field signs table sign settings
---@field underline boolean show/hide underline control
---@field update_in_insert boolean update whether in insert mode or not
---@field severity_sort boolean sort by severity
---@field float table floating window settings

-- -----
-- Linting
--
-- respect to nvim-lint
-- -----
---@class (exact) kengo.Linting
---@field linters_by_ft table<kengo.Filetype, kengo.LinterName[]>
---@field linters table<string, lint.Linter|fun():lint.Linter>
---@field opts string
---@field files table<string>

-- -----
-- Formatting
--
-- respect to conform.nvim: .local/share/nvim/lazy/conform.nvim/lua/conform/types.lua
-- -----
---@class (exact) kengo.Formatting
---@field formatters_by_ft table<string, conform.FiletypeFormatter> Map of filetype to formatters
---@field formatters table<kengo.FormatterName, conform.FormatterConfig>

---@class (exact) kengo.FormatterConfig
---@field prepend_args? string|string[]|fun(self: conform.FormatterConfig, ctx: conform.Context): string|string[]
---@field files table<kengo.FormatterName, conform.FormatterConfig> file names which a formatter can reffer
---@field condition? fun(self: conform.JobFormatterConfig, ctx: conform.Context): boolean
