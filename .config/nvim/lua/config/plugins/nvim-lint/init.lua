local M = {}

function M.setLinters()
  local lint = require("lint")
  local linters = require("lint").linters

  -- cf.) lua/config/plugins/mason-tool-installer/init.lua
  lint.linters_by_ft = {
    -- lua = { "luacheck" },
    -- markdown = { "markdownlint" },
    dockerfile = { "hadolint" },
    editorconfig = { "editorconfig-checker" },

    php = { "phpstan" },
    python = { "ruff" },
    sql = { "sqlfluff" },
    yaml = { "yamllint" },

    sh = { "shellcheck" },
    -- zsh = { "zsh" },
  }

  linters.phpstan.args = {
    "-n",
    "--no-progress",
    "--memory-limit=2G",
    "-c",
    vim.fn.getcwd() .. "/phpstan.neon",
    "-a",
    "vendor/autoload.php",
  }

  linters.sqlfluff.args = {
    "--config",
    vim.fn.getcwd() .. "/.sqlfluff",
    "--dialect",
    "mysql",
    "--encoding",
    "utf8",
    "--exclude-rules",
    "AL09",
    "--disable-progress-bar",
    "-f",
    "github-annotation",
    "-n",
  }

  linters.shellcheck.args = {
    "--shell=bash",
    "--format=json",
    "-",
  }

  linters.yamllint.args = {
    "--config-file",
    vim.fn.stdpath("config") .. "/yamllint/config",
    "--format=parsable",
    "-",
  }
end

-- @return boolean
local function ft_is_js()
  local js_file_types = {
    "astro",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "css",
  }

  local ft = vim.bo.filetype
  if not vim.tbl_contains(js_file_types, ft) then
    return false
  end

  return true
end

-- @return void
local function try_biomejs()
  local biome_config_files = { "biome.json", "biome.jsonc" }
  if vim.fs.root(0, biome_config_files) then
    require("lint").try_lint("biomejs")
  end
end

-- @return void
local function try_eslint_d()
  local eslint_config_files = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  }
  if vim.fs.root(0, eslint_config_files) then
    require("lint").try_lint("eslint_d")
  end
end

local function try_js_linters()
  if not ft_is_js() then
    return
  end

  try_biomejs()

  try_eslint_d()
end

function M.setTriggers()
  local lint = require("lint")

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
      -- run the linters configured in `linters_by_ft`
      lint.try_lint()

      -- run the js linters
      try_js_linters()
    end,
  })
end

function M.setKeymaps()
  local km = require("core.key_mapper")
  local opts = {
    noremap = true,
    silent = true,
    desc = "[L]int [L]int!",
  }
  km.nmap("<leader>ll", function()
    require("lint").try_lint()
  end, opts)
end

return M
