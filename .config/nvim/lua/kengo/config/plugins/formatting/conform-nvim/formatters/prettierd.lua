local M = {}

---@type string[]
M.append_args = { "--config" }

---@type string[]
M.files = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yml",
  ".prettierrc.yaml",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
  "package.json",
  ".editorconfig",
}

---Disable prettierd formattings when the buffer's ft is markdown
---@type fun(self: conform.JobFormatterConfig, ctx: conform.Context): boolean
M.condition = function(self, ctx)
  local md_filetypes = { "markdown", "mdx", "mdc", "codecompanion" }
  local ft = vim.bo[ctx.buf].filetype

  return not vim.tbl_contains(md_filetypes, ft)
end

return M
