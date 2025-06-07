local km = require("kengo.core.key_mapper")

return {
  { "zbirenbaum/copilot.lua" },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    cmd = { "CodeCompanionChat", "CodeCompanionActions" },
    config = function()
      -- cf.) https://github.com/olimorris/codecompanion.nvim/discussions/813
      local config_codecompanion = require("kengo.config.plugins.ai.codecompanion")
      config_codecompanion:init()

      local codecompanion = require("codecompanion")
      codecompanion.setup({
        -- cf.) available adapters found here:
        --  https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
        --  https://github.com/olimorris/codecompanion.nvim/discussions/858
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  -- default = "gpt-4o",
                  -- default = "o3-mini-2025-01-31",
                  -- default = "gemini-2.5-pro",
                  -- default = "claude-3.5-sonnet",
                  -- default = "claude-3.7-sonnet",
                  default = "claude-sonnet-4",
                },
                max_tokens = {
                  default = 8192,
                  -- default = 16384,
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "copilot",
            roles = {
              llm = function(adapter)
                return "  CodeCompanion (" .. adapter.formatted_name .. ")"
              end,
              user = "  Me",
            },
            slash_commands = {
              ["file"] = {
                -- Location to the slash command in CodeCompanion
                callback = "strategies.chat.slash_commands.file",
                -- description = "Select a file using Telescope",
                opts = {
                  provider = "snacks", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                  show_hidden = true,
                },
              },
            },
          },
          inline = {
            adapter = "copilot",
          },
        },
        display = {
          action_palette = {
            provider = "default", -- default|telescope|mini_pick
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            },
          },
          chat = {
            -- a yaml block will be present at the top of the chat buffer which can be modified in between responses
            show_settings = true,
            auto_scroll = false,
            show_header_separator = true,
            -- separator = "-",
          },
        },
        opts = {
          send_code = true, -- prevent any code from being sent to the LLM
          log_level = "INFO", -- TRACE|DEBUG|ERROR|INFO
          language = "English",
        },
      })

      -- enable automatic tool mode
      -- cf.) https://codecompanion.olimorris.dev/usage/chat-buffer/agents.html#automatic-tool-mode
      vim.g.codecompanion_auto_tool_mode = true

      -- keymaps
      -- km.nmap("<leader>cc", codecompanion.toggle, { desc = "[C]odecompanion toggle [C]hat window" })
      km.nmap("<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "[C]odecompanion [A]ctions" })
      km.vmap("<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "[C]odecompanion [A]ctions" })
    end,
  },
}
