-- @see: Available adapters:
-- https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
-- https://github.com/olimorris/codecompanion.nvim/discussions/858

-- e.g.) Model multipliers:
-- @see: https://docs.github.com/ja/copilot/managing-copilot/understanding-and-managing-copilot-usage/understanding-and-managing-requests-in-copilot
-- @see: https://github.com/olimorris/codecompanion.nvim/blob/6ca8768ad9aff0d6f46dcf8db576843e519e2035/tests/adapters/http/copilot/test_copilot.lua#L7
-- we can see the models in th Copilot adaper by `ga` command in a CodeCompanion Chat buffer:
--  e.g.) Models
--  claude-3.7-sonnet-thought
--  claude-sonnet-4.5
--  gemini-2.0-flash-001
--  gemini-2.5-pro
--  gpt-4.1
--  gpt-5
--  gpt-5-codex
local default_model = "gpt-4.1"

local M = {}

M.http = {
  copilot = function()
    return require("codecompanion.adapters").extend("copilot", {
      schema = {
        model = {
          default = default_model,
          choices = {
            ["claude-3.7-sonnet"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["claude-3.7-sonnet-thought"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["claude-sonnet-4.5"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["gpt-4.1"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["gpt-5"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["gpt-5-codex"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
            ["gemini-2.5-pro"] = {
              opts = { has_vision = true, can_stream = true, can_use_tools = true },
            },
          },
        },
        temperature = {
          default = 0.1,
        },
        max_tokens = {
          default = 524288, -- 2^19
        },
      },
    })
  end,
  -- https://github.com/olimorris/codecompanion.nvim/discussions/1576#discussioncomment-13681339
  jina = function()
    return require("codecompanion.adapters").extend("jina", {
      env = {
        api_key = "cmd:op read op://development/jina.ai/api_key --no-newline",
      },
    })
  end,
}

M.acp = {
  gemini_cli = function()
    return require("codecompanion.adapters").extend("gemini_cli", {
      commands = {
        default = {
          "mise",
          "exec",
          "gemini-cli",
          "--",
          "gemini",
          "--experimental-acp",
        },
      },
      defaults = {
        auth_method = "gemini-api-key", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
      },
      env = {
        GEMINI_API_KEY = "cmd:op read op://development/gemini_cli/api_key --no-newline",
      },
    })
  end,
}

return M
