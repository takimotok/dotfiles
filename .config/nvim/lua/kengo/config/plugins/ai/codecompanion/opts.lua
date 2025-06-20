local M = {}

local default_adapter = "copilot"

-- e.g.) default models:
-- default = "gpt-4o",
-- default = "o3-mini-2025-01-31",
-- default = "gemini-2.5-pro",
-- default = "claude-3.5-sonnet",
-- default = "claude-3.7-sonnet",
local default_model = "claude-sonnet-4"

-- available adapters found here:
-- https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
-- https://github.com/olimorris/codecompanion.nvim/discussions/858
M.opts = {
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = default_model,
          },
          max_tokens = {
            default = 8192, -- e.g.) 16384
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = default_adapter,
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
          opts = {
            provider = "snacks", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
            contains_code = true,
            show_hidden = true,
          },
        },
      },
    },
    inline = {
      adapter = default_adapter,
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
  extensions = {
    history = {
      enabled = true,
      opts = {
        picker = "snacks",
        title_generation_opts = {
          adapter = default_adapter,
          model = default_model,
        },
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion/histories",
      },
    },
  },
}

return M
