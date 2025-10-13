local km = require("util.key_mapper")
local config_codecompanion_opts = require("kengo.config.plugins.ai.codecompanion.opts")

return {
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
}
