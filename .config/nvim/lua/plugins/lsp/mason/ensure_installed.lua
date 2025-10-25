local M = {}

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

local ai_related_tools = {
  -- for codecompanion-history
  "vectorcode",
}

---@return string[]
local function _get()
  local merged = vim.tbl_extend("force", {}, linters, formatters, ai_related_tools)

  return merged
end

-- Install Formatters, Linters, DAPs and AI related tools.
---@return nil
function M.install()
  local mason_registry = require("mason-registry")

  ---@type string[]
  local installed_package_names = mason_registry.get_installed_package_names()
  local ensure_installed = _get()

  -- Filter packages to be installed
  ---@type string[] Filterd package names to be installed
  local should_be_installed = vim.tbl_filter(function(package)
    return not vim.tbl_contains(installed_package_names, package) and type(package) ~= "function"
  end, ensure_installed)

  if vim.tbl_isempty(should_be_installed) then
    return nil
  end

  vim.cmd({
    cmd = "MasonInstall",
    args = vim.iter(should_be_installed):flatten():totable(),
  })
end

return M
