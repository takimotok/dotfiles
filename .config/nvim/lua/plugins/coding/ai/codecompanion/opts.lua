local M = {
  adapters = require("plugins.coding.ai.codecompanion.adapters"),
  strategies = require("plugins.coding.ai.codecompanion.strategies"),
  memory = require("plugins.coding.ai.codecompanion.memory"),
  display = require("plugins.coding.ai.codecompanion.display"),
  opts = {
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
  },
  extensions = require("plugins.coding.ai.codecompanion.extensions"),
  prompt_library = require("plugins.coding.ai.codecompanion.prompt_library"),
}

return M
