local M = {}

M.ensure_installed = {}

local lsps = {
  -- astro
  "astro-language-server",
  -- awk
  "awk-language-server",
  -- bash
  "bash-language-server",
  -- js
  "biome", -- also available as liter and formatter
  "eslint-lsp",
  "typescript-language-server",
  "vtsls",
  "vue-language-server",
  -- css
  "css-lsp",
  "stylelint-lsp",
  -- docker
  "docker-compose-language-service",
  "dockerfile-language-server",
  "json-lsp",
  -- lua
  "lua-language-server",
  -- markdown
  "marksman",
  -- php
  "phpactor",
  -- python
  "pyright",
  "ruff",
  -- rust
  "rust-analyzer",
  -- sql
  "sqls",
  -- tailwind
  "tailwindcss-language-server",
  -- toml
  "taplo",
}

local linters = {
  -- spell
  "cspell",
  -- editorconfig
  "editorconfig-checker",
  -- js
  "eslint_d",
  -- lua
  "luacheck",
  -- git
  "gitlint",
  -- php
  "phpcs",
  "phpstan",
  -- shell
  "shellcheck",
  -- sql
  "sqlfluff",
  -- yaml
  "yamllint",
}

local formatters = {
  -- python
  "black",
  "isort",
  -- latex
  "latexindent",
  -- markdown
  "markdownlint-cli2", -- also available as linter
  -- php
  "php-cs-fixer",
  -- js
  "prettierd",
  -- rust
  "rustfmt",
  -- shell
  "shfmt",
  -- lua
  "stylua",
  -- yaml
  "yamlfmt",
}

local function set_lsps()
  for _, lsp in pairs(lsps) do
    table.insert(M.ensure_installed, lsp)
  end
end

local function set_linters()
  for _, linter in pairs(linters) do
    table.insert(M.ensure_installed, linter)
  end
end

local function set_formatters()
  for _, formatter in pairs(formatters) do
    table.insert(M.ensure_installed, formatter)
  end
end

local function set_ensure_installed()
  set_lsps()
  set_linters()
  set_formatters()
end

function M.init()
  set_ensure_installed()
end

return M
