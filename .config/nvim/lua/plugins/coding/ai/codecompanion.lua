local km = require("util.key_mapper")
local opts = require("plugins.coding.ai.codecompanion.opts")

-- debug start
-- vim.notify("opts: " .. vim.inspect(opts))
-- debug end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "j-hui/fidget.nvim",
    "ravitemer/codecompanion-history.nvim",
    "Davidyz/VectorCode",
    "franco-ruggeri/codecompanion-spinner.nvim",
    "ravitemer/mcphub.nvim",
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    {
      "<C-a>",
      "<cmd>CodeCompanionActions<CR>",
      desc = "Open the action palette",
      mode = { "n", "v" },
    },
  },
  opts = opts,
  config = function(_, user_opts)
    require("codecompanion").setup(user_opts)

    -- Link CodeCompanion highlight groups to Visual
    vim.api.nvim_set_hl(0, "CodeCompanionChatError", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatFold", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatHeader", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatInfo", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatInfoBanner", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatSeparator", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatSubtext", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatTokens", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatTool", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatToolGroups", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatVariable", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionChatWarn", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionSuperDiffDirectory", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionSuperDiffFilename", { link = "Visual" })
    vim.api.nvim_set_hl(0, "CodeCompanionVirtualText", { link = "Visual" })

    -- enable automatic tool mode
    -- cf.) https://codecompanion.olimorris.dev/usage/chat-buffer/agents.html#automatic-tool-mode
    vim.g.codecompanion_auto_tool_mode = true

    -- NOTE: show copilot's stats by this command:
    km.nmap("<C-c><C-c>", function()
      require("codecompanion.adapters").resolve("copilot").show_copilot_stats()
    end, { desc = "Show Copilot Stats" })
  end,
}
