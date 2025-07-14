local cfg_path_manager = require("kengo.util.config_files.path_manager")
local notifier = require("kengo.util.notifier")

---@class NvimLintUtils 設定ファイル探索のユーティリティ関数
local M = {}

--- linter 名と config の table を取得
--- init.lua は除外.
--- err. 時は {} を返す.
---@param dir? string directory contains linter setting files
---@return table<kengo.LinterName, kengo.LinterConfig>|{}
function M.find_linters(dir)
  if not dir then
    dir = vim.fn.stdpath("config") .. "/lua/kengo/config/plugins/linting/nvim-lint/linters"
  end

  local files = vim.fn.readdir(dir)
  if not files then
    local info = debug.getinfo(1, "Slfn")
    local message = "Failed to read linter directory: " .. dir
    notifier.error(message, info)

    return {}
  end

  local linters = {}
  for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" and file ~= "init.lua" then
      local name = file:sub(1, -5)
      local module_name = "kengo.config.plugins.linting.nvim-lint.linters." .. name

      linters[name] = require(module_name)
    end
  end

  return linters
end

---linter name の名寄せ処理
---xdg dir. 配下の dir. 名と, nvim-lint が管理する linter 名が異なるため mapping を行う
---@param name kengo.LinterName 名寄せ前の linter name
---@return kengo.LinterName 名寄せ後の linter name
function M.identify_name(name)
  local name_mapping = {
    ["eslint_d"] = "eslint",
    ["biomejs"] = "biome",
    ["editorconfig-checker"] = "editorconfig",
  }

  local mapped_name = name_mapping[name]
  if mapped_name then
    return mapped_name
  end

  return name
end

---@return table<kengo.LinterName, lint.Linter|fun():lint.Linter>
function M.setup()
  local res = {}
  local linters = M.find_linters()

  local lint = require("lint")
  for name, config in pairs(linters) do
    -- cf.) :h lint, README
    -- nvim-lint 設定では, `original` は次の2パターン存在する
    --  1. table
    --  2. function
    -- もし function なら下記のように instance 化する必要がある
    local original = lint.linters[name]
    if not original then
      local info = debug.getinfo(1, "Slfn")
      local message = "Linter not found in nvim-lint: " .. name
      notifier.error(message, info)

      goto continue
    end

    local linter = original
    if type(original) == "function" then
      linter = original()
    end

    local identified_name = M.identify_name(name)
    local found_config_file_path = cfg_path_manager.find_config_file(identified_name, config.files)
    if not found_config_file_path then
      local info = debug.getinfo(1, "Slfn")
      local message = "Failed to find linter config: " .. name
      notifier.error(message, info)

      res[name] = linter

      goto continue
    end

    linter.args = linter.args or {}
    vim.list_extend(linter.args, config.opts)
    table.insert(linter.args, found_config_file_path)

    res[name] = linter

    ::continue::
  end

  -- return lint.linters
  return res
end

---@return NvimLintUtils
return M
