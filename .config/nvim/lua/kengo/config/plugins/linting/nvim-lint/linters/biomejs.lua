--@class NvimLintModule
local M = {}

--@type string[]
M.opts = { "--config-path=" }

--@type string[]
M.files = {
  "biome.jsonc",
  "biome.json",
  ".biomejs.json",
}

return M
