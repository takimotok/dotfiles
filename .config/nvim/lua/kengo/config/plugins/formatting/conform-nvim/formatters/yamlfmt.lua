local M = {}

---@type string[]
M.append_args = { "-conf" }

---@type string[]
M.files = {
  ".yamlfmt",
  ".yamlfmt.yaml",
  ".yamlfmt.yml",
  ".editorconfig",
}

return M
