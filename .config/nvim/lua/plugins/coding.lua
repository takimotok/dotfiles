local km = require("kengo.core.key_mapper")
local config_blink_cmp = require("kengo.config.plugins.coding.blink-cmp")

return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "Saghen/blink.cmp",
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
      },
      {
        "Saghen/blink.compat",
      },
    },
    opts = function(_, opts)
      -- 基本設定を取得
      local base_opts = config_blink_cmp.opts

      -- LazyVimのデフォルト設定を上書き
      if base_opts.sources and base_opts.sources.providers and base_opts.sources.providers.copilot then
        -- kindフィールドを削除
        base_opts.sources.providers.copilot.kind = nil
      end

      return base_opts
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      -- カスタムハイライトを適用
      require("kengo.config.ui.blink_highlights").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load()

      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets/" },
      })
    end,
  },
  {
    "godlygeek/tabular",
    ft = { "csv" },
    config = function()
      -- .csv keymaps
      km.nmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
      km.xmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })

      -- .md
      -- km.nmap("<C-;>", ":Tabularize /|<CR>", { desc = "format csv by comma" })
    end,
  },
}
