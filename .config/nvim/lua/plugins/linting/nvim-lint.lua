local opts = require("plugins.linting.nvim-lint.opts")

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  opts = opts,
  config = function(_, user_opts)
    local lint = require("lint")

    -- 重要: linters_by_ft を反映して、markdown では markdownlint-cli2 のみを実行
    if user_opts and user_opts.linters_by_ft then
      lint.linters_by_ft = user_opts.linters_by_ft
    end

    -- FileType 決定時や保存/挿入終了時に実行
    vim.api.nvim_create_autocmd({ "FileType", "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
