local M = {}

function M.setup()
  local dap = require("dap")
  local dap_python = require("dap-python")

  dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
  }

  dap_python.setup()
  -- make sure making configuration in docker-compose to mount ports
  table.insert(dap.configurations.python, {
    type = "python",
    request = "attach",
    connect = {
      port = 5678,
      host = "localhost",
    },
    name = "Container Attach Debug",
    cwd = "${workspaceFolder}",
    pathMappings = {
      {
        localRoot = "${workspaceFolder}",
        remoteRoot = "/app",
      },
    },
  })
end

return M
