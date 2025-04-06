local M = {}

function M.set_formatters_by_ft()
  local t = {}

  -- local js_formatter = { "biome-check", "prettierd", stop_after_first = true }
  local js_formatter = { "prettierd", stop_after_first = true }
  t.astro = { "prettierd", "biome-check" }
  t.markdown = { "markdownlint-cli2" }
  t.json = js_formatter
  t.jsonc = js_formatter
  t.javascript = js_formatter
  t.javascriptreact = js_formatter
  t.typescript = js_formatter
  t.typescriptreact = js_formatter
  -- t.yaml = js_formatter
  t.html = js_formatter
  t.css = js_formatter

  t.python = { "isort", "black", "ruff" }
  -- t.php = { "blade-formatter", "php-cs-fixer" }
  t.php = { "php-cs-fixer" }
  t.tex = { "latexindent" }
  t.lua = { "stylua" }
  t.sh = { "shfmt" }
  t.bash = { "shfmt" }
  -- t._ = { "trim_whitespace" } -- avoid formmating in .md files
  t._ = { "editorconfig" } -- avoid formmating in .md files

  return t
end

function M.format_on_save(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname:match("/node_modules/") then
    return false
  end

  -- .editorconfig がない場合は何もしない
  if vim.fn.filereadable(vim.fn.getcwd() .. "/.editorconfig") == 0 then
    return false
  end

  return false
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
      "--config=.php-cs-fixer.php", -- プロジェクト固有の設定を使用
      "$FILENAME",
    },
    stdin = false,
  },

  ["markdownlint-cli2"] = {
    args = {
      "--config",
      vim.env.XDG_CONFIG_HOME .. "/markdownlint-cli2/.markdownlint-cli2.jsonc",
      "--fix",
      "$FILENAME",
    },
  },
}

return M

