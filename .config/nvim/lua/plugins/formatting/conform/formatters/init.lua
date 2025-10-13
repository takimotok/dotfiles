local util = require("util")
local cfg_path_manager = require("util.config_files.path_manager")
local notifier = require("util.notifier")

---@class table<FormatterName, table>
local M = {}

--- formatter 名と config の table を取得
--- init.lua は除外.
--- err. 時は {} を返す.
---@param dir? string directory contains formatter setting files
---@return table<kengo.FormatterName, kengo.FormatterConfig>|{}
function M.find_formatters(dir)
  if not dir then
    dir = vim.fn.stdpath("config") .. "/lua/kengo/config/plugins/formatting/conform-nvim/formatters"
  end

  local files = vim.fn.readdir(dir)
  if not files then
    local info = debug.getinfo(1, "Slfn")
    local message = "Failed to read formatter directory: " .. dir
    notifier.error(message, info)

    return {}
  end

  local formatters = {}
  for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" and file ~= "init.lua" then
      local name = file:sub(1, -5)
      local module_name = "kengo.config.plugins.formatting.conform-nvim.formatters." .. name

      formatters[name] = require(module_name)
    end
  end

  return formatters
end

---formatter name の名寄せ処理
---@param name kengo.FormatterName 名寄せ前の formatter name
---@return kengo.FormatterName 名寄せ後の formatter name
function M.identify_name(name)
  local name_mapping = {
    ["biome-check"] = "biome",
    ["prettierd"] = "prettier",
    ["ruff_fix"] = "ruff",
    ["eslint_d"] = "eslint",
  }

  local mapped_name = name_mapping[name]
  if mapped_name then
    return mapped_name
  end

  return name
end

---@return table<kengo.FormatterName, conform.FormatterConfig> conform.formatters
function M.setup()
  local configured_formatters = M.find_formatters()
  local formatters = {}
  for name, configs in pairs(configured_formatters) do
    local identified_name = M.identify_name(name)
    local found_config_file_path = cfg_path_manager.find_config_file(identified_name, configs.files)
    if not found_config_file_path then
      local info = debug.getinfo(1, "Slfn")
      local message = "Failed to find formatter config: " .. name
      notifier.error(message, info)

      goto continue
    end

    local append_args = util.merge_tables({}, configs.append_args or {})
    table.insert(append_args, found_config_file_path)

    local formatter_config = {}
    formatter_config.append_args = append_args

    if configs.condition ~= nil then
      formatter_config.condition = configs.condition
    end

    formatters[name] = formatter_config

    ::continue::
  end

  return formatters
end

return M
