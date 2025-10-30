local M = {}

local js_linters = { "eslint_d", "biome" }

M = {
  -- lua
  lua = { "luacheck" },

  -- js
  astro = js_linters,
  javascript = js_linters,
  typescript = js_linters,
  javascriptreact = js_linters,
  typescriptreact = js_linters,
  gitcommit = { "gitlint" },

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
  --
  yaml = { "yamllint" },
}

return M
