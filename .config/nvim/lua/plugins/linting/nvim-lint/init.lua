local linters_by_ft = require("plugins.linting.nvim-lint.linters_by_ft")
local linters = require("plugins.linting.nvim-lint.linters")

-- debug start
-- vim.notify("linters: " .. vim.inspect(config_nvim_lint.linters))
-- debug end

return {
  "mfussenegger/nvim-lint",
  events = {
    "FileType",
    "BufWritePost",
    "InsertLeave",
  },
  opts = {
    linters_by_ft = linters_by_ft,
    linters = linters,
  },
}
