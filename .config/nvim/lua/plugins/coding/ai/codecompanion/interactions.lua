local xdg_cache_home = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")

local constants = require("plugins.coding.ai.codecompanion.constants")

local M = {
  chat = {
    opts = {
      completion_provider = "blink", -- blink|cmp|coc|default
    },

    variables = {},

    -- HACK: We can NOT use spaces into `chat.roles.user`.
    -- @see: https://github.com/olimorris/codecompanion.nvim/issues/1067#issuecomment-2700520015
    roles = {
      ---@type string|fun(adapter: CodeCompanion.Adapter): string
      llm = function(adapter)
        local adapter_name = adapter.formatted_name or "CodeCompanion"
        local model_name = (adapter.model and adapter.model.name)
          or (adapter.schema and adapter.schema.model and adapter.schema.model.default)
          or ""
        if model_name ~= "" then
          return string.format("%s %s (%s / %s)", "", "CodeCompanion", adapter_name, model_name)
        end
        return string.format("%s %s (%s)", "", "CodeCompanion", adapter_name)
      end,

      ---@type string
      user = string.format("%s %s", "", "Me"),
    },

    adapter = {
      name = constants.DEFAULT_ADAPTER_NAME,
      model = constants.DEFAULT_ADAPTER_MODEL,
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
      ["run_command"] = {
        opts = {
          allowed_in_yolo_mode = true,
          require_cmd_approval = false,
          require_approval_before = false,
        },
      },
    },
    shared = {
      keymaps = {
        always_accept = {
          callback = "keymaps.always_accept",
          modes = { n = "y" },
          opts = { nowait = true },
        },
        reject_change = {
          callback = "keymaps.reject_change",
          modes = { n = "q" },
          opts = { nowait = true, noremap = true },
        },
        test_shared_keymaps = {
          callback = function()
            vim.notify("shared.keymaps is active", vim.log.levels.INFO)
          end,
          modes = { n = "<leader>k" },
          opts = { nowait = true, silent = true, desc = "Test shared.keymaps" },
        },
      },
    },
  },
}

return M
