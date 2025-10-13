local M = {}

---@type string[]
M.append_args = { "--cr" }

---@type string[]
M.files = {
  ".isort.cfg",
  "pyproject.toml",
  "setup.cfg",
  "tox.ini",
}

return M
