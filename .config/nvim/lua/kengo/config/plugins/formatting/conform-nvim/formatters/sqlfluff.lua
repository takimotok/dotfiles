local M = {}

---@type string[]
M.prepend_args = { "--config" }

---@type string[]
M.files = {
  ".sqlfluff",
  "pep8.ini",
  "pyproject.toml",
  "setup.cfg",
  "tox.ini",
}

return M
