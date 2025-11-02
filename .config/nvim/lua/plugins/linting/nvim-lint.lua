local opts = require("plugins.linting.nvim-lint.opts")

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  opts = opts,
  config = function(_, user_opts)
    local lint = require("lint")

    if user_opts and user_opts.linters_by_ft then
      lint.linters_by_ft = user_opts.linters_by_ft
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
