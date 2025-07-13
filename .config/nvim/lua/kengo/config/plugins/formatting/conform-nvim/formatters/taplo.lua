local M = {}

---@type string[]
M.prepend_args = { "--config" }

---@type string[]
M.files = {
  ".taplo.toml",
  "taplo.toml",
}

return M
