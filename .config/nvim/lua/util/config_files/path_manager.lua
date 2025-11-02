---@class ConfigFilePathManager
local M = {}

-- @TODO: it might be better to merge markers per project or language
---@type string[]
local ROOT_MARKERS = {
  ".git",
  ".github",
  ".gitignore",
  "package.json",
  "composer.json",
  "pyproject.toml",
  "setup.py",
  "Cargo.toml",
  "go.mod",
  "pom.xml",
  "build.gradle",
  "Makefile",
  ".zk",
  ".editorconfig",
}

---プロジェクトルートを検出する
---@param start_path string 検索開始パス
---@return string|nil project_root プロジェクトルートのパス
function M.find_project_root(start_path)
  return vim.fs.root(start_path, ROOT_MARKERS)
end

---設定ファイルを次の順に探索する
---1. current directory
---2. project root
---3. $XDG_CONFIG_HOME/{linter_or_formatter_name}/
---@param linter_or_formatter_name kengo.LinterName|kengo.FormatterName linter 名 or formatter 名
---@param config_files kengo.ConfigFileName[] 設定ファイル名のリスト
---@param current_file_path? string 現在のファイルパス（省略時は現在のバッファから取得）
---@return string|nil config_path 見つかった設定ファイルのパス
function M.find_config_file(linter_or_formatter_name, config_files, current_file_path)
  if not config_files or #config_files == 0 then
    return nil
  end

  -- find current directory
  local current_file = current_file_path or vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    current_file = vim.fn.getcwd()
  end
  local current_dir = vim.fs.dirname(current_file)

  -- 1. current working directory から探索
  local cwd = vim.fn.getcwd()
  local cwd_config = vim.fs.find(config_files, {
    path = cwd,
    follow = true,
  })[1]
  if cwd_config then
    return cwd_config
  end

  -- 2. project root を探して、そこから探索
  local project_root = M.find_project_root(current_dir)

  if project_root then
    local project_config = vim.fs.find(config_files, {
      path = project_root,
      follow = true,
    })[1]

    if project_config then
      return project_config
    end
  end

  -- 3. XDG_CONFIG_HOME/{linter_or_formatter_name}/ 配下から探索
  local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
  local xdg_config_path = xdg_config_home .. "/" .. linter_or_formatter_name
  local xdg_config = vim.fs.find(config_files, {
    path = xdg_config_path,
    follow = true,
  })[1]

  if xdg_config then
    return xdg_config
  end

  -- 4. 設定ファイルが見つからない場合は nil を返す（masonのデフォルト挙動に委ねる）
  return nil
end

---find executable path
---@param default_command string デフォルトコマンド名
---@param ctx? table コンテキスト情報
---@return string command_path 見つかったコマンドのパス
function M.find_command(default_command, ctx)
  local cwd = vim.fn.getcwd()
  if ctx and ctx.bufnr then
    local bufname = vim.api.nvim_buf_get_name(ctx.bufnr)
    if bufname and bufname ~= "" then
      cwd = vim.fn.fnamemodify(bufname, ":h")
    end
  end

  local project_root = M.find_project_root(cwd)
  if project_root then
    -- vendor/bin (PHP)
    local vendor_cmd = project_root .. "/vendor/bin/" .. default_command
    if vim.fn.executable(vendor_cmd) == 1 then
      return vendor_cmd
    end
    -- node_modules/.bin (Node.js)
    local node_modules_cmd = project_root .. "/node_modules/.bin/" .. default_command
    if vim.fn.executable(node_modules_cmd) == 1 then
      return node_modules_cmd
    end
  end

  -- Mason
  local mason_cmd = vim.fn.stdpath("data") .. "/mason/bin/" .. default_command
  if vim.fn.executable(mason_cmd) == 1 then
    return mason_cmd
  end

  return default_command
end

---@return NvimLintUtils
return M
