local M = {}

---@type string[]
M.prepend_args = { "-l" }

---@type string[]
M.files = {
  "latexindent.yaml",
  ".latexindent.yaml",
  "localSettings.yaml",
}

return M
