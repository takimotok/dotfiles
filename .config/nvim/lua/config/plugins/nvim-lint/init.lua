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

    -- javascript = { "eslint_d" },
    -- javascriptreact = { "eslint_d" },
    -- typescript = { "eslint_d" },
    -- typescriptreact = { "eslint_d" },
    -- json = { "jsonlint" },

    javascript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescript = { "biomejs" },
    typescriptreact = { "biomejs" },
    json = { "biomejs" },

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

function M.try_js_linters()
  local cwd = vim.fn.getcwd()
  local bufnr = vim.api.nvim_get_current_buf()

  local js_file_types = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
  }

  -- if no js related files are opened in the current buffer, then return
  local ft = vim.bo.filetype
  if not vim.tbl_contains(js_file_types, ft) then
    return
  end

  -- @TODO: 2024-10-15 root path に config file が存在するか, のチェック実装から
  -- vim.fs.root()

  -- if the cwd has the biome related config files, then try_lint("biomejs")
  if M.hasBiomeConfig(cwd) then
    require("lint").try_lint("biomejs")
  end

  -- if the cwd has the eslint related config files, then try_lint("eslint_d")
  if M.hasEslintConfig(cwd) then
    require("lint").try_lint("eslint_d")
  end

  return ft == "javascript" or ft == "javascriptreact" or ft == "typescript" or ft == "typescriptreact"

  -- check if configuration files are exist in the `cwd`
  -- local eslint = vim.fn.glob(".eslintrc*", 0, 1)
  -- return #eslint > 0
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
      M.try_js_linters()
    end,
  })
end

function M.setKeymaps()
  local km = require("core.key_mapper")
  local opts = { noremap = true, silent = true }
  km.nmap("<leader>ll", function()
    require("lint").try_lint()
  end, opts)
end

return M
