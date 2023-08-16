local configs = require("config.plugins.null_ls")
local km = require("core.key_mapper")

return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local mason_null_ls = require("mason-null-ls")

      configs.setup(null_ls)

      mason_null_ls.setup({
        ensure_installed = configs.ensure_installed,
        automatic_installation = true,
      })

      null_ls.setup({
        diagnostic_config = configs.diagnostic_config,
        diagnostics_format = configs.diagnostics_format,
        sources = configs.sources,
        on_attach = configs.on_attach,
      })

      -- keymaps
      km.nmap("<leader>li", "<cmd>NullLsInfo<CR>")
    end,
  },
}
