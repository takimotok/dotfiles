require("kengo.types")

---@class NvimLintUtils 設定ファイル探索のユーティリティ関数
local M = {}

-- @TODO: it might be better to merge markers per project or language
local PROJECT_ROOT_MARKERS = {
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
  ".editorconfig",
}

---プロジェクトルートを検出する
---@param start_path string 検索開始パス
---@return string|nil project_root プロジェクトルートのパス
local function find_project_root(start_path)
  return vim.fs.root(start_path, PROJECT_ROOT_MARKERS)
end

---設定ファイルを探索する
---@param linter_name LinterName リンター名
---@param config_files ConfigFileName[] 設定ファイル名のリスト
---@param current_file_path? string 現在のファイルパス（省略時は現在のバッファから取得）
---@return string|nil config_path 見つかった設定ファイルのパス
function M.find_config_file(linter_name, config_files, current_file_path)
  if not config_files or #config_files == 0 then
    return nil
  end

  -- 現在のファイルのディレクトリを取得
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
  local project_root = find_project_root(current_dir)

  if project_root then
    local project_config = vim.fs.find(config_files, {
      path = project_root,
      follow = true,
    })[1]

    if project_config then
      return project_config
    end
  end

  -- 3. XDG_CONFIG_HOME/{linter_name}/ 配下から探索
  local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
  local xdg_config_path = xdg_config_home .. "/" .. linter_name
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

  local project_root = find_project_root(cwd)
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

--- 下記 dir. 指定した linter file 名を取得
--- vim.fn.stdpath("config") .. "/lua/kengo/config/plugins/linting/nvim-lint/linters"
--- init.lua を除外した file 名を返す
---@return LinterName[]
function M.find_linters()
  local linters_dir = vim.fn.stdpath("config") .. "/lua/kengo/config/plugins/linting/nvim-lint/linters"
  local linter_files = vim.fn.readdir(linters_dir)

  local linter_names = {}
  for _, file in ipairs(linter_files) do
    if file:sub(-4) == ".lua" and file ~= "init.lua" then
      table.insert(linter_names, file:sub(1, -5))
    end
  end

  return linter_names
end

function M.setup_linters()
  local linter_names = M.find_linters()

  local require_path = "kengo.config.plugins.linting.nvim-lint.linters"

  local lint = require("lint")
  for _, linter_name in ipairs(linter_names) do
    local ok, linter_config = pcall(require, require_path .. "." .. linter_name)

    if not ok then
      local info = debug.getinfo(1, "Slfn")
      local message = "Failed to load linter"
      M.notify_errors(message, info)

      goto continue
    end

    local config_files = linter_config.files
    local config_opts = linter_config.opts
    local original = lint.linters[linter_name]
    lint.linters[linter_name] = function()
      -- cf.) :h lint, README
      -- nvim-lint 設定では, `original` は次の2パターン存在する
      --  1. table
      --  2. function
      -- もし function なら下記のように instance 化する必要がある
      local linter = original
      if type(original) == "function" then
        linter = original()
      end

      local found_config_file_path = M.find_config_file(linter_name, config_files)
      if not found_config_file_path then
        ---@type lint.Linter
        return linter
      end

      linter.args = linter.args or {}
      vim.list_extend(linter.args, config_opts)
      table.insert(linter.args, found_config_file_path)

      ---@type lint.Linter
      return linter
    end

    ::continue::
  end

  return lint.linters
end

--- notify errors
---@param message string error message
---@param info table<string, any> debug info
function M.notify_errors(message, info)
  if not message then
    return
  end

  if not info or #info == 0 then
    return
  end

  vim.notify("🤔 nvim-lint error: " .. message, vim.log.levels.ERROR, {
    title = string.format(
      "File: %s | Function: %s | Line: %d",
      info.short_src or info.source,
      info.name or "unknown",
      info.currentline or -1
    ),
  })
end

---@return NvimLintUtils
return M
