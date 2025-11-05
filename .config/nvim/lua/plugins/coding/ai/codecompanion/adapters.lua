-- @see: Available adapters:
-- https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
-- https://github.com/olimorris/codecompanion.nvim/discussions/858

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

local M = {
  http = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = default_model,
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
  },
  acp = {
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
  },
}

return M
