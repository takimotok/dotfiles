local M = {}

M.ensure_installed = {}

local lsps = {
  "astro-language-server",
  "awk-language-server",
  "bash-language-server",
  "biome", -- also available as liter and formatter
  "css-lsp",
  "eslint-lsp",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "phpactor",
  "pyright",
  "ruff",
  "rust-analyzer",
  "sqls",
  "stylelint-lsp",
  "tailwindcss-language-server",
  "taplo",
  "typescript-language-server",
  "vue-language-server",
}

local linters = {
  "cspell",
  "editorconfig-checker",
  "eslint_d",
  "hadolint",
  "luacheck",
  "markdownlint-cli2", -- also available as formatter
  "phpstan",
  "ruff",
  "shellcheck",
  "sqlfluff",
  "yamllint",
}

local formatters = {
  "black",
  "isort",
  "latexindent",
  "markdown-toc",
  "php-cs-fixer",
  "prettierd",
  "ruff",
  "shfmt",
  "stylua",
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
