local opts = require("plugins.linting.nvim-lint.opts")

-- debug start
-- vim.notify("linters: " .. vim.inspect(linters))
-- debug end

return {
  "mfussenegger/nvim-lint",
  events = {
    "FileType",
    "BufWritePost",
    "InsertLeave",
  },
  opts = opts,
  config = function()
    local nvim_lint = require("lint")

    vim.api.nvim_create_autocmd({ "FileType", "BufWritePost", "InsertLeave" }, {
      callback = function()
        nvim_lint.try_lint()
      end,
    })
  end,
}
