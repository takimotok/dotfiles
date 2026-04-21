local XDG_CONFIG_HOME = os.getenv("XDG_COHNFIG_HOME") or (os.getenv("HOME") .. "/.config")

-- available model names:
-- @see: tests/adapters/http/copilot/test_copilot.lua
-- OR we can see it by debug as follows:
--  `vim.notify(vim.inspect(all_models))  `

local constants = require("plugins.coding.ai.codecompanion.constants")

local M = {}

M.http = {
  opts = {
    show_presets = false, -- display the adapters defined in the configuration below
  },
  copilot = function()
    return require("codecompanion.adapters").extend("copilot", {
      schema = {
        model = {
          -- default = "gpt-4.1",
          -- default = "gpt-5-mini",

          default = constants.DEFAULT_ADAPTER_MODEL,
          choices = function(adapter, opts)
            -- get all models
            local all_models = require("codecompanion.adapters.http.copilot.get_models").choices(adapter, opts)

            -- debug
            -- vim.notify(vim.inspect(all_models))

            -- specify model ids which would like to show
            local allowed_models = {
              "gpt-5-mini",
              "gpt-5.4",
              "gpt-5.4-mini",
              "claude-opus-4.6",
              "claude-sonnet-4.6",
              "gemini-3.1-pro-preview",
              "gemini-3-flash-preview",
            }

            -- filtering
            local filtered_models = {}
            for model_id, model_data in pairs(all_models or {}) do
              if vim.tbl_contains(allowed_models, model_id) then
                -- Use a human-friendly label for the UI: prefer formatted_name, then description, then the raw id
                filtered_models[model_id] = model_data.formatted_name or model_data.description or model_id
              end
            end

            return filtered_models
          end,
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
  opts = {
    show_presets = false, -- display the adapters defined in the configuration below
  },
  copilot_acp = function()
    return require("codecompanion.adapters").extend("copilot_acp", {
      commands = {
        default = {
          "copilot",
          "--acp",
          "--config-dir",
          XDG_CONFIG_HOME .. "/copilot",
          "--experimental",
          "--max-autopilot-continues",
          "3",
          "--mode", -- "interactive", "plan", "autopilot"
          "autopilot",
          "--yolo",
        },
      },
    })
  end,
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
        mcpServers = "inherit_from_config",
      },
      env = {
        GEMINI_API_KEY = "cmd:op read op://development/gemini_cli/api_key --no-newline",
      },
    })
  end,
}

return M
