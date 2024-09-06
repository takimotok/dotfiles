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

function M.setTriggers()
  local lint = require("lint")

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  -- keymaps
  local km = require("core.key_mapper")
  local opts = { noremap = true, silent = true }
  km.nmap("<leader>ll", function()
    lint.try_lint()
  end, opts)
end

return M
