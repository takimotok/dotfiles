local M = {
  adapters = require("plugins.coding.ai.codecompanion.adapters"),
  interactions = require("plugins.coding.ai.codecompanion.interactions"),
  mcp = require("plugins.coding.ai.codecompanion.mcp"),
  prompt_library = require("plugins.coding.ai.codecompanion.prompt_library"),
  rules = require("plugins.coding.ai.codecompanion.rules"),
  display = require("plugins.coding.ai.codecompanion.display"),
  extensions = require("plugins.coding.ai.codecompanion.extensions"),
  opts = {
    log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
  },
}

return M
