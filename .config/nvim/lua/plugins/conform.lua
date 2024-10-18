local config = require("config.plugins.conform")
local km = require("core.key_mapper")

return {
  "stevearc/conform.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = config.set_formatters_by_ft(),
      format_on_save = config.format_on_save,
      formatters = config.formatters,
      default_format_opts = {
        lsp_format = "never",
      },
    })

    -- keymaps
    local fmt = function()
      conform.format({
        lsp_fallback = "never",
        async = false,
        timeout_ms = 500,
      })
    end
    km.nmap("<leader>gf", fmt, { desc = " Format & Save" })
  end,
}
