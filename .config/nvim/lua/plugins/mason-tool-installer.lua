local configs = require("config.plugins.mason-tool-installer")

return {
  -- for LSP, linters and formatters plugin such as:
  --  - nvim-lint.nvim
  --  - conform.nvim
  --
  --  cf.) lua/config/autocmds.lua
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "williamboman/mason.nvim" },
  init = configs.init(),
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = configs.ensure_installed,
      auto_update = false,
      run_on_start = true,
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
      },
    })
  end,
}
