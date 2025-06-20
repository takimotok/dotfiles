require("kengo.types")

local M = {}

---@type FormatterName[] JavaScript/TypeScript formatters
-- local js_formatters = { "prettierd", stop_after_first = true }
local js_formatters = { "biome-check", "prettierd", stop_after_first = true }

---@type FormatterName[] Markdown formatters
local md_formatters = { "markdownlint-cli2" }

---@type table<FiletypeName, FormatterName[]> formatters per filetype
M.formatters_by_ft = {
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
  -- lua
  lua = { "stylua" },
  -- markdown
  ["markdown"] = md_formatters,
  ["markdown.mdx"] = md_formatters,
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
  sh = { "shfmt" },
  -- sql
  sql = { "sqlfluff" },
  -- toml
  toml = { "taplo" },
  -- yaml
  yaml = { "yamlfmt" },
}

--- find formatter's config file as follow:
--- - from: project local
--- - to: project root and XDG CONFIG DIRECTORY
---@param config_files table<ConfigFileName[]> list of config file name
---@param formatter_name FormatterName formatter name
---@return fun(self: any, ctx: conform.Context): string|nil 作業ディレクトリを返す関数
local function find_config(config_files, formatter_name)
  return function(_, ctx)
    -- search configs from project local to the parent dir.
    local project_root = vim.fs.root(ctx.dirname, config_files)
    if project_root then
      return project_root
    end

    -- search configs in the XDG_CONFIG_HOME
    local formatter_config_dir = vim.fn.expand("$XDG_CONFIG_HOME") .. "/" .. formatter_name
    if vim.fn.isdirectory(formatter_config_dir) == 1 then
      return formatter_config_dir
    end

    return nil
  end
end

---@type table<FormatterName, ConfigFileName[]> フォーマッターごとの設定ファイルリスト
local formatter_configs = {
  black = { "pyproject.toml", "setup.cfg", ".black" },
  isort = { ".isort.cfg", "pyproject.toml", "setup.cfg", "tox.ini" },
  latexindent = { "latexindent.yaml", ".latexindent.yaml", "localSettings.yaml" },
  ["markdownlint-cli2"] = {
    ".markdownlint-cli2.jsonc",
    ".markdownlint-cli2.yaml",
    ".markdownlint-cli2.cjs",
    ".markdownlint.jsonc",
    ".markdownlint.json",
    ".markdownlint.yaml",
    ".markdownlint.yml",
    ".editorconfig",
  },
  ["php-cs-fixer"] = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php", ".editorconfig" },
  prettierd = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
    "package.json",
    ".editorconfig",
  },
  shfmt = { ".editorconfig" },
  stylua = { ".stylua.toml", "stylua.toml" },
  yamlfmt = { ".yamlfmt", ".yamlfmt.yaml", ".yamlfmt.yml", ".editorconfig" },
}

---@type table<FormatterName, conform.FormatterConfig> conform formatter 詳細設定
M.formatters = {}

-- map formatter name and its command name
---@type table<FormatterName, string>
local formatter_commands = {
  black = "black",
  isort = "isort",
  latexindent = "latexindent.pl",
  ["markdownlint-cli2"] = "markdownlint-cli2",
  ["php-cs-fixer"] = "php-cs-fixer",
  prettierd = "prettierd",
  prettier = "prettier",
  shfmt = "shfmt",
  stylua = "stylua",
  yamlfmt = "yamlfmt",
}

for formatter_name, config_files in pairs(formatter_configs) do
  M.formatters[formatter_name] = {
    inherit = true,
    cwd = find_config(config_files, formatter_name),
    require_cwd = true, -- When cwd is not found, don't run the formatter (default false)
    command = formatter_commands[formatter_name] or formatter_name,
  }

  -- always enable markdownlint-cli2
  if formatter_name == "markdownlint-cli2" then
    M.formatters[formatter_name].condition = function(self, ctx)
      return true
    end
  end

  -- disallow prettier like formatters to markdown files
  if formatter_name == "prettierd" or formatter_name == "prettier" then
    M.formatters[formatter_name].condition = function(_, ctx)
      local md_filetypes = { "markdown", "mdx", "mdc", "codecompanion" }
      local ft = vim.bo[ctx.buf].filetype
      return not vim.tbl_contains(md_filetypes, ft)
    end
  end
end

return M
