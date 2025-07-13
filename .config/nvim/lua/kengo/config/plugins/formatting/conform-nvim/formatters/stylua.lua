local M = {}

---@type string[]
M.prepend_args = { "--config-path" }

---@type string[]
M.files = {
  ".stylua.toml",
  "stylua.toml",
}

return M
