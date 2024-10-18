local M = {}

function M.set_formatters_by_ft()
  local t = {}

  local js_formatter = { "biome-check", "prettierd", stop_after_first = true }
  t.json = js_formatter
  t.javascript = js_formatter
  t.javascriptreact = js_formatter
  t.typescript = js_formatter
  t.typescriptreact = js_formatter
  t.yaml = js_formatter
  t.html = js_formatter
  t.css = js_formatter

  t.python = { "isort", "black", "ruff" }
  t.php = { "blade-formatter", "php-cs-fixer" }
  t.tex = { "latexindent" }
  t.lua = { "stylua" }
  t.sh = { "shfmt" }
  t.bash = { "shfmt" }
  -- t._ = { "trim_whitespace" } -- avoid formmating in .md files

  return t
end

function M.format_on_save(bufnr)
  -- Disable autoformat for files in a certain path
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#autoformat-with-extra-features
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname:match("/node_modules/") then
    return
  end

  return {
    lsp_format = "never",
    async = false,
    timeout_ms = 500,
  }
end

M.formatters = {
  shfmt = {
    command = "shfmt",
    stdin = false,
    prepend_args = {
      "-i",
      "2",
      "--to-json",
    },
  },
  black = {
    -- cf.) https://github.com/stevearc/conform.nvim/issues/248#issuecomment-1867422813
    prepend_args = { "--fast" },
  },
  ["php-cs-fixer"] = {
    command = "php-cs-fixer",
    args = {
      "fix",
      -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
      "--rules=@PSR12",
      "$FILENAME",
    },
    stdin = false,
  },
}

return M
