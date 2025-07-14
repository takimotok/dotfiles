local M = {}

---@type string[]
M.prepend_args = { "--config-path=" }

---@type string[]
M.files = {
  "biome.json",
  "biome.jsonc",
}

return M
