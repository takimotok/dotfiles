--@class NvimLintModule
local M = {}

--@type string[]
M.opts = { "--config" }

--@type string[]
M.files = {
  "cspell.json",
  ".cspell.json",
  "cspell.config.js",
  ".cspell.config.js",
  "cspell.yaml",
  ".cspell.yaml",
}

return M
