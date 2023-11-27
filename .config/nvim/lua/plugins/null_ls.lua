local configs = require("config.plugins.null_ls")

return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls.nvim",
      -- "williamboman/mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local mason_null_ls = require("mason-null-ls")

      configs.setup(null_ls)

      mason_null_ls.setup({
        ensure_installed = configs.ensure_installed,
        automatic_installation = true,
        handlers = {
          function() end,
        },
      })

      null_ls.setup({
        -- debug = true,
        -- log_level = "info",
        default_timeout = 60000, -- msec
        temp_dir = "/tmp",
        diagnostic_config = configs.diagnostic_config,
        diagnostics_format = configs.diagnostics_format,
        sources = configs.sources,
        on_attach = configs.on_attach,
      })
    end,
  },
}
