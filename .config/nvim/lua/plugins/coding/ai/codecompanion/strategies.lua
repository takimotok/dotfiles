-- e.g.) Model multipliers:
-- https://docs.github.com/ja/copilot/managing-copilot/understanding-and-managing-copilot-usage/understanding-and-managing-requests-in-copilot
-- we can see the models in th Copilot adaper by `ga` command in a CodeCompanion Chat buffer:
--  claude-3.5-sonnet
--  claude-3.7-sonnet
--  claude-3.7-sonnet-thought
--  claude-sonnet-4.5
--  gemini-2.0-flash-001
--  gemini-2.5-pro
--  gpt-4.1
--  gpt-4o
--  gpt-5
--  gpt-5-codex
--  gpt-5-mini
--  grok-code-fast-1
--  o3-mini
--  o4-mini
local default_model = "gpt-4.1"

local default_adapter = "copilot"

local xdg_cache_home = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")

-- @see: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
local M = {
  chat = {
    adapter = default_adapter,
    model = default_model,
    opts = {
      completion_provider = "blink", -- blink|cmp|coc|default
    },
    roles = {
      llm = function(adapter)
        return "  CodeCompanion (" .. adapter.formatted_name .. ")"
      end,
      user = "  Me",
    },
    slash_commands = {
      ["file"] = {
        -- Location to the slash command in CodeCompanion
        -- callback = "strategies.chat.slash_commands.catalog.file",
        opts = {
          provider = "snacks", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
          contains_code = true,
          show_hidden = true,
        },
      },
      ["fetch"] = {
        opts = {
          cache_path = xdg_cache_home .. "/nvim/codecompanion/urls",
        },
      },
    },
    tools = {
      opts = {
        auto_submit_errors = true, -- Send any errors to the LLM automatically?
        auto_submit_success = true, -- Send any successful output to the LLM automatically?
      },
      ["cmd_runner"] = {
        opts = {
          requires_approval = true,
        },
      },
    },
  },
  inline = {
    adapter = default_adapter,
  },
  cmd = {
    adapter = default_adapter,
  },
}

return M
