local config_nvim_lint = require("kengo.config.plugins.linting.nvim-lint")

-- debug start
-- vim.notify("linters: " .. vim.inspect(config_nvim_lint.linters))
-- debug end

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      events = {
        "FileType",
        "BufWritePost",
        "InsertLeave",
      },
      linters_by_ft = config_nvim_lint.linters_by_ft,
      linters = config_nvim_lint.linters,
    },
  },
}
