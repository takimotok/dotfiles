local M = {}

---@type string[]
M.append_args = { "--config" }

---@type string[]
M.files = {
  ".markdownlint-cli2.jsonc",
  ".markdownlint-cli2.yaml",
  ".markdownlint-cli2.cjs",
  ".markdownlint.jsonc",
  ".markdownlint.json",
  ".markdownlint.yaml",
  ".markdownlint.yml",
}

---@type fun(self: conform.JobFormatterConfig, ctx: conform.Context): boolean
M.condition = function(self, ctx)
  return vim.bo.filetype == "markdown"
end

return M
