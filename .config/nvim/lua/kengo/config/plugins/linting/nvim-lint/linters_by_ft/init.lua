---@class LintersByFtModule ファイルタイプごとのリンター設定モジュール
---@field linters_by_ft table<FiletypeName, LinterName[]> ファイルタイプごとのリンター設定
local M = {}

local js_linters = { "eslint_d" }

M.linters_by_ft = {
  -- js
  astro = js_linters,
  javascript = js_linters,
  typescript = js_linters,
  javascriptreact = js_linters,
  typescriptreact = js_linters,
  gitcommit = { "gitlint" },
  -- lua
  lua = { "luacheck" },
  -- markdown
  markdown = { "markdownlint-cli2" },
  ["markdown.mdx"] = { "markdownlint-cli2" },
  -- editorconfig
  editorconfig = { "editorconfig-checker" },
  -- php
  php = { "phpstan", "phpcs" },
  -- shell
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "shellcheck" },
  -- sql
  sql = { "sqlfluff" },
  -- yaml
  yaml = { "yamllint" },
}

---@return LintersByFtModule
return M
