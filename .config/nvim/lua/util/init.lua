-- local fs = require("conform.fs")
local M = {}

M.md_filetypes = {
  "markdown",
  "mdx",
  "mdc",
  "codecompanion",
}

local local_opts = { noremap = true, silent = true }
for _, mode in pairs({ "n", "v", "i", "s", "o", "c", "t", "x" }) do
  M[mode .. "map"] = function(lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", local_opts, opts))
  end
end

return M
