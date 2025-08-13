local M = {}

---@type string[]
M.append_args = { "--config" }

---@type string[]
M.files = {
  "pyproject.toml",
  "setup.cfg",
  ".black",
}

return M
