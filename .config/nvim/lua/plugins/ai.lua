local km = require("kengo.core.key_mapper")
local config_codecompanion_opts = require("kengo.config.plugins.ai.codecompanion.opts")

return {
  -- blink.cmpのCopilot設定を修正（LazyVimの設定を完全に上書き）
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = function(_, opts)
      -- LazyVimのデフォルト設定を確実に上書き
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}

      -- copilotプロバイダーを正しく設定（kindフィールドなし）
      opts.sources.providers.copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
        -- kind フィールドを意図的に除外
      }

      -- copilotをdefaultソースに追加（まだなければ）
      if not vim.tbl_contains(opts.sources.default, "copilot") then
        table.insert(opts.sources.default, 1, "copilot")
      end

      return opts
    end,
  },
  { "zbirenbaum/copilot.lua" },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      "ravitemer/codecompanion-history.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "franco-ruggeri/codecompanion-lualine.nvim",
      "ravitemer/mcphub.nvim",
    },
    cmd = { "CodeCompanionChat", "CodeCompanionActions" },
    opts = config_codecompanion_opts.opts,
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- Link CodeCompanion highlight groups to Visual
      vim.api.nvim_set_hl(0, "CodeCompanionChatTool", { link = "Visual" })
      vim.api.nvim_set_hl(0, "CodeCompanionChatVariable", { link = "Visual" })

      -- enable automatic tool mode
      -- cf.) https://codecompanion.olimorris.dev/usage/chat-buffer/agents.html#automatic-tool-mode
      vim.g.codecompanion_auto_tool_mode = true

      -- keymaps
      -- km.nmap("<leader>cc", codecompanion.toggle, { desc = "[C]odecompanion toggle [C]hat window" })
      km.nmap("<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "[C]odecompanion [A]ctions" })
      km.vmap("<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "[C]odecompanion [A]ctions" })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "Joakker/lua-json5",
        -- manually executed in $XDG_DATA_HOME/nvim/lazy/lua-json5
        -- due to not work `build` spec
        -- e.g.)
        --  $ cd $XDG_DATA_HOME/nvim/lazy/lua-json5
        --  $ ./install.sh
        build = "./install.sh",
      },
    },
    -- install `mcp-hub` node binary globally by mise
    -- @see ~/.config/mise/config.toml
    build = "mise use -g npm:mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        json_decode = require("json5").parse,
      })
    end,
  },
}
