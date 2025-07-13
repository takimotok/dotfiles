local M = {}

---@type string[]
M.prepend_args = { "--config-path" }

---@type string[]
M.files = {
  "rustfmt.toml",
  ".rustfmt.toml",
}

return M
