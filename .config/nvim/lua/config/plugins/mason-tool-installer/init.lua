local M = {}

M.filetypes = {
  "dockefile",
  "editorconfig",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "php",
  "python",
  "sql",
  "yaml",
  "sh",
  "zsh",
  "bash",
}

M.linters = {
  "cspell",
  "editorconfig-checker",
  "eslint_d",
  "hadolint",
  "jsonlint",
  "phpstan",
  "ruff", -- @TODO: LSP, Linter, Formatter 全てで存在している. LSP のみの設定で OK?
  "sqlfluff",
  "yamllint",
  -- "zsh",
  -- "markdownlint",
  -- "phpcs",
}

M.formatters = {
  "black",
  -- "blade-formatter",
  -- "biome",
  "isort",
  "latexindent",
  "php-cs-fixer",
  "prettierd",
  "shfmt",
  "stylua",
}

M.daps = {
  "codelldb",
}

M.ensure_installed = {}

local function set_linters()
  for _, linter in ipairs(M.linters) do
    table.insert(M.ensure_installed, linter)
  end
end

local function set_formatters()
  for _, formatter in ipairs(M.formatters) do
    table.insert(M.ensure_installed, formatter)
  end
end

local function set_daps()
  for _, dap in ipairs(M.daps) do
    table.insert(M.ensure_installed, dap)
  end
end

function M.init()
  set_linters()
  set_formatters()
  set_daps()
end

return M
