local M = {}

local xdg_cache_home = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")

local default_adapter = "copilot"

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
local default_model = "claude-sonnet-4.5"

-- @see: Available adapters:
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
    -- https://github.com/olimorris/codecompanion.nvim/discussions/1576#discussioncomment-13681339
    jina = function()
      return require("codecompanion.adapters").extend("jina", {
        env = {
          api_key = "cmd:op read op://development/jina.ai/api_key --no-newline",
        },
      })
    end,
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
  },
  strategies = {
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
          callback = "strategies.chat.slash_commands.file",
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
    agent = {
      tools = {
        ["fetch"] = {
          rate_limit = 1, -- 1秒間隔でリクエスト制限
        },
      },
    },
  },
  display = {
    action_palette = {
      provider = "snacks", -- default|telescope|fzf_lua|mini_pick|snacks
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
      icons = {
        chat_context = " ", -- an icon to the fold
      },
      fold_context = true,
    },
    inline = {
      layout = "vertical", -- vertical|horizontal|buffer
    },
    diff = {
      enabled = true,
      provider = "split", -- mini_diff|split|inline
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
        -- open history from chat buffer (default: gh)
        keymap = "gh",
        picker = "snacks",
        title_generation_opts = {
          adapter = "copilot",
          model = "gpt-4o",
        },
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion/histories",

        -- Summary system
        summary = {
          -- Keymap to generate summary for current chat
          create_summary_keymap = "gcs",
          -- Keymap to browse summaries
          browse_summaries_keymap = "gbs",

          generation_opts = {
            adapter = "copilot",
            model = "gpt-4o",
            context_size = 8192, -- max tokens that the model supports
          },
        },
      },
    },
    spinner = {},
    -- https://ravitemer.github.io/mcphub.nvim/extensions/codecompanion.html
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -----
        -- MCP Tools
        -----
        -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        make_tools = true,
        -- Show individual tools in chat completion (when make_tools=true)
        show_server_tools_in_chat = true,
        -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        add_mcp_prefix_to_tool_names = false,
        -- Show tool results directly in chat buffer
        show_result_in_chat = true,
        -- function(tool_name:string, tool: CodeCompanion.Agent.Tool):
        --    string Function to format tool names to show in the chat buffer
        format_tool = nil,
        -----
        -- MCP Resources
        -----
        -- Convert MCP resources to #variables for prompts
        make_vars = true,
        -----
        -- MCP Prompts
        -----
        -- Add MCP prompts as /slash commands
        make_slash_commands = true,
      },
    },
  },
  prompt_library = {
    ["With Instructions"] = {
      strategy = "chat",
      description = "general.instructions.md を前提にチャット",
      opts = {
        short_name = "inst",
        auto_submit = false,
      },
      context = {
        {
          type = "file",
          path = ".github/instructions/general.instructions.md",
        },
      },
      prompts = {
        {
          role = "user",
          content = "以降、このファイルの内容を前提にchatを行います。",
        },
      },
    },
  },
}

return M
