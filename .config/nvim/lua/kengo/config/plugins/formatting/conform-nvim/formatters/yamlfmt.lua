local M = {}

---@type string[]
M.prepend_args = { "-conf" }

---@type string[]
M.files = {
  ".yamlfmt",
  ".yamlfmt.yaml",
  ".yamlfmt.yml",
  ".editorconfig",
}

return M
