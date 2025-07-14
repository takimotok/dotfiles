local M = {}

local function get_lsp_client_name(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    -- 複数のクライアントがある場合は最初のものを返す
    return clients[1].name
  end
  return nil
end

-- linterディレクトリからlinter名一覧を取得する関数
local function get_linter_names()
  local linter_dir = vim.fn.stdpath("config") .. "/lua/kengo/config/plugins/linting/nvim-lint/linters/"
  local linter_names = {}

  -- ディレクトリが存在するかチェック
  if vim.fn.isdirectory(linter_dir) == 0 then
    return linter_names
  end

  -- ディレクトリ内のLuaファイルを取得
  local files = vim.fn.glob(linter_dir .. "*.lua", false, true)
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t:r") -- 拡張子を除いたファイル名
    if filename ~= "init" then -- init.luaは除外
      table.insert(linter_names, filename)
    end
  end

  return linter_names
end

-- sourceがlinter名かどうかをチェックする関数
local function is_linter_source(source, linter_names)
  if not source or source == "" then
    return false
  end

  -- linter名と一致するかチェック
  for _, linter_name in ipairs(linter_names) do
    if source == linter_name then
      return true
    end
  end

  return false
end

local function format_diagnostic(diagnostic)
  local source = diagnostic.source or ""
  local message = diagnostic.message
  local bufnr = vim.api.nvim_get_current_buf()
  local linter_names = get_linter_names()

  local icon = "🔧" -- default icon: LS
  local client_name = source
  if source and source ~= "" then
    -- linterからの診断
    if is_linter_source(source, linter_names) then
      icon = "🔍"
    end

    -- linter: markdownlint-cli2 からの診断
    if source == "markdownlint" then
      icon = "🔍"
      client_name = "markdownlint-cli2"
    end
  else
    -- sourceが空の場合, かつ, アクティブな LS クライアントがある場合に client_name をセット
    -- 複数のクライアントがある場合は最初のものを返す
    local lsp_client_name = get_lsp_client_name(bufnr)
    if lsp_client_name then
      client_name = lsp_client_name
    else
      client_name = "LS"
    end
  end

  return string.format("%s [%s]: %s", icon, client_name, message)
end

function M.get_diagnostic_config()
  return {
    virtual_text = false, -- virtual textを無効化
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "⚠️",
        [vim.diagnostic.severity.HINT] = "💡",
        [vim.diagnostic.severity.INFO] = "󰙎",
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = false, -- ソース情報を表示
      header = "",
      prefix = "",
      format = format_diagnostic, -- カスタムフォーマッター
      suffix = function(diagnostic)
        -- 診断の重要度を表示
        local severity_name = vim.diagnostic.severity[diagnostic.severity] or "INFO"
        return string.format(" [%s]", severity_name)
      end,
    },
  }
end

-- 診断設定を即座に適用する関数
function M.setup()
  local config = M.get_diagnostic_config()
  vim.diagnostic.config(config)
end

return M
