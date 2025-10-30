---@type kengo.FormatterName[] JavaScript/TypeScript formatters
-- local js_formatters = { "prettierd", stop_after_first = true }
local js_formatters = { "biome-check", "prettierd", stop_after_first = true }

---@type kengo.FormatterName[] Markdown formatters
local md_formatters = { "markdownlint-cli2" }

---@type table<kengo.Filetype, kengo.FormatterName[]> formatters per filetype
local M = {
  -- lua
  lua = { "stylua" },
  -- js
  astro = js_formatters,
  javascript = js_formatters,
  javascriptreact = js_formatters,
  typescript = js_formatters,
  typescriptreact = js_formatters,
  -- json
  json = js_formatters,
  jsonc = js_formatters,
  -- html, css
  html = js_formatters,
  css = js_formatters,
  -- markdown
  ["markdown"] = md_formatters,
  -- ["markdown.mdx"] = md_formatters,
  -- php
  php = { "php_cs_fixer" },
  -- python
  python = { "isort", "black", "ruff" },
  -- rust
  rust = { "rustfmt" },
  -- git
  gitcommit = { "prettierd" },
  gitignore = { "prettierd" },
  -- shell
  -- shfmt searches `.editorconfig by default
  -- cf.) https://github.com/mvdan/sh/blob/c00e5d71/cmd/shfmt/shfmt.1.scd
  sh = { "shfmt" },
  -- sql
  sql = { "sqlfluff" },
  -- toml
  toml = { "taplo" },
  -- yaml
  yaml = { "yamlfmt" },
}

return M
