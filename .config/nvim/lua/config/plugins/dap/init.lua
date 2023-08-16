local dap_keymaps = require("config.plugins.dap.keymaps")
local lua_config = require("config.plugins.dap.lua")
local python_config = require("config.plugins.dap.python")

local M = {}

local function configure_extensions()
  local dap = require("dap")
  local dapui = require("dapui")

  dap.set_log_level("TRACE")

  dapui.setup()

  -- set dap listeners to control dap-ui behavior
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function configure_debuggers()
  lua_config.setup()
  python_config.setup()
end

local function configure_keymaps()
  dap_keymaps.setup()
end

function M.setup()
  configure_extensions()
  configure_debuggers()
  configure_keymaps()
end

return M
