local M = {}

M.ensure_installed = {
  "black",
  "blade-formatter",
  "codelldb",
  "editorconfig_checker",
  "hadolint",
  "isort",
  "php-cs-fixer",
  "phpstan",
  "prettier",
  "ruff",
  "shfmt",
  "sqlfluff",
  "stylua",
  -- "cspell",
  -- "phpcs",
}

M.diagnostic_config = {
  virtual_text = false,
}

-- #{m}: message
-- #{s}: source name (defaults to null-ls if not specified)
-- #{c}: code (if available)
-- @see: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/CONFIG.md#diagnostics_format-string
M.diagnostics_format = "[#{c}] (#{s}) #{m}"

M.sources = {}

---@param null_ls table
local function set_sources(null_ls)
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  M.sources = {
    -- shell
    formatting.shfmt.with({
      filetypes = { "zsh", "sh" },
    }),

    -- lua
    formatting.stylua,

    -- python
    formatting.black.with({
      extra_args = { "--line-length=120" },
    }),
    formatting.isort,
    -- formatting.ruff,
    -- diagnostics.ruff,
    -- code_actions.ruff,

    -- php, laravel
    formatting.phpcsfixer.with({
      name = "phpcsfixer",
      condition = function(utils)
        return utils.root_has_file(".php-cs-fixer.dist.php")
      end,
      command = "vendor/bin/php-cs-fixer",
      extra_args = function()
        return {
          "--quiet",
          "--no-interaction",
          "--config=" .. vim.fn.getcwd() .. "/.php-cs-fixer.dist.php",
          "$FILENAME",
        }
      end,
    }),
    -- formatting.blade_formatter,
    diagnostics.phpstan.with({
      name = "phpstan",
      -- milliseconds
      -- timeout = 60000,
      condition = function(utils)
        return utils.root_has_file("phpstan.neon")
      end,
      command = "vendor/bin/phpstan",
      extra_args = function()
        return {
          "-n",
          -- "--error-format",
          -- "raw",
          "--no-progress",
          "--memory-limit=2G",
          "-c",
          vim.fn.getcwd() .. "/phpstan.neon",
          "-a",
          "vendor/autoload.php",
          -- "$FILENAME",
        }
      end,
    }),

    -- markdown
    formatting.prettier,

    -- editorconfig
    diagnostics.editorconfig_checker,

    -- hadolint
    -- diagnostics.hadolint.with({
    --   filetypes = { "Dockerfile", "dockerfile" },
    -- }),
    diagnostics.hadolint,

    -- sqlfluff
    -- @TODO: can I set a config file ?
    -- @TODO: bug: be overwritten whenever we save it. how can I solve that ?
    diagnostics.sqlfluff.with({
      extra_args = {
        "--config",
        ".sqlfluff",
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
        -- "$FILENAME",
        -- "-",
      },
    }),
    formatting.sqlfluff.with({
      extra_args = {
        "--config",
        ".sqlfluff",
        "--dialect",
        "mysql",
        "--encoding",
        "utf8",
        "-n",
        "--disable-noqa",
        "--disable-progress-bar",
        -- "$FILENAME",
        -- "-",
      },
    }),

    -- cspell
    -- diagnostics.cspell.with({
    --   diagnostics_postprocess = function(diagnostic)
    --     diagnostic.severity = vim.diagnostic.severity["INFO"]
    --   end,
    --   condition = function()
    --     -- enavle cspell only when it is executable
    --     return vim.fn.executable("cspell") > 0
    --   end,
    --   -- read configuration file when startup
    --   extra_args = { "--config", "~/.config/cspell/cspell.json" },
    -- }),
  }
end

---@param null_ls table
function M.setup(null_ls)
  set_sources(null_ls)
end

--- format on save
---@param client "lsp client"
---@param bufnr number
function M.on_attach(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {
    clear = true,
  })

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

return M
