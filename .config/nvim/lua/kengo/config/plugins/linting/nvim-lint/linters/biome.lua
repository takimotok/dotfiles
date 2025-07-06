--@class NvimLintModule
local M = {}

--@type string[]
M.opts = { "--config-path" }

--@type string[]
M.files = {
  "biome.json",
  ".biomejs.json",
  "biome.jsonc",
}

return M
