local M = {}

---@type string[]
M.append_args = { "--config" }

---@type string[]
M.files = {
  "pyproject.toml",
  "ruff.toml",
  ".ruff.toml",
}

return M
