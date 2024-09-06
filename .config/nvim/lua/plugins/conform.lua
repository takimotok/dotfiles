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
      format_on_save = {
        lsp_format = "first",
        async = false,
        timeout_ms = 500,
      },
      formatters = config.formatters,
    })

    -- keymaps
    local fmt = function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end
    km.nmap("<leader>gf", fmt, { desc = " Format & Save" })
  end,
}
