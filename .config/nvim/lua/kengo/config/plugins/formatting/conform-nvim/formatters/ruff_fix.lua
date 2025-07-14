local M = {}

---@type string[]
M.prepend_args = { "--config" }

---@type string[]
M.files = {
  "pyproject.toml",
  "ruff.toml",
  ".ruff.toml",
}

return M
