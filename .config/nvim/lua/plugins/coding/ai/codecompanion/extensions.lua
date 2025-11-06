local M = {
  -- @see: https://github.com/franco-ruggeri/codecompanion-spinner.nvim
  spinner = {},
  history = {
    enabled = true,
    opts = {
      -- open history from chat buffer (default: gh)
      keymap = "gh",
      picker = "snacks",
      title_generation_opts = {
        adapter = "copilot",
        model = "gpt-4.1",
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
          model = "gpt-4.1",
          context_size = 8192, -- max tokens that the model supports
        },
      },
    },
  },
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
  -- https://github.com/Davidyz/VectorCode/blob/main/docs/neovim/README.md#olimorriscodecompanionnvim
  vectorcode = {
    ---@type VectorCode.CodeCompanion.ExtensionOpts
    opts = {
      tool_group = {
        -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
        enabled = true,
        -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
        -- if you use @vectorcode_vectorise, it'll be very handy to include
        -- `file_search` here.
        extras = {},
        collapse = false, -- whether the individual tools should be shown in the chat
      },
      tool_opts = {
        ---@type VectorCode.CodeCompanion.ToolOpts
        ["*"] = {},
        ---@type VectorCode.CodeCompanion.LsToolOpts
        ls = {},
        ---@type VectorCode.CodeCompanion.VectoriseToolOpts
        vectorise = {},
        ---@type VectorCode.CodeCompanion.QueryToolOpts
        query = {
          max_num = { chunk = -1, document = -1 },
          default_num = { chunk = 50, document = 10 },
          include_stderr = false,
          use_lsp = false,
          no_duplicate = true,
          chunk_mode = false,
          ---@type VectorCode.CodeCompanion.SummariseOpts
          summarise = {
            ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
            enabled = false,
            adapter = nil,
            query_augmented = true,
          },
        },
        files_ls = {},
        files_rm = {},
      },
    },
  },
}

return M
