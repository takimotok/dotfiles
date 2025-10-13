local M = {}

---@type string[]
M.append_args = { "--config-path" }

---@type string[]
M.files = {
  "rustfmt.toml",
  ".rustfmt.toml",
}

return M
