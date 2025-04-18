local km = require("core.key_mapper")

return {
  { "keaising/im-select.nvim" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers = { "<cmd>WhichKey" },
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()

      -- NORMAL mode
      -- - `gcc` - Toggles the current line using linewise comment
      -- - `gbc` - Toggles the current line using blockwise comment
      -- - `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
      -- - `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
      -- - `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
      -- - `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
      --
      -- VISUAL mode
      -- - `gc` - Toggles the region using linewise comment
      -- - `gb` - Toggles the region using blockwise comment
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    opts = {
      char = "┊",
      show_end_of_line = false,
      show_trailing_blankline_indent = false,
      -- space_char_blankline = " ",
    },
    config = function()
      -- @TODO: think about which is better to display:
      --  - indnet-blankline
      --  - OR spaces by a character (e.g.) `vim.opt.listchars:append "space:⋅"`

      -- keymaps
      km.nmap(
        "<leader>t",
        ":IBLToggle<CR>",
        { desc = "Toggles between IndentBlanklineEnable and IndentBlanklineDisable" }
      )
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
        },
        oldfiles = {
          theme = "dropdown",
        },
        help_tags = {
          theme = "dropdown",
        },
        command_history = {
          theme = "dropdown",
        },
        registers = {
          theme = "dropdown",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
        },
      },
    },
    config = function()
      -- keymaps
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
            n = {
              ["<esc>"] = actions.close,
            },
          },
          layout_strategy = "vertical",
          file_ignore_patterns = {
            "%.archive./",
            "%.jpeg",
            "%.jpg",
            "%.lock",
            "%.pdf",
            "%.png",
            "%lock%.",
            "%old/",
            ".DS_Store",
            ".bin/",
            ".git/",
            ".yarn/",
            ".zk/",
            "build",
            "dist",
            "drafts/",
            "node_modules",
            "vendor",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      -- extensions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("nerdy")

      -- keymappings
      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")

      km.nmap(
        "<leader>ff",
        builtin.find_files,
        { desc = "[F]ind [F]iles. Lists files in your current working directory, respects .gitignore" }
      )

      km.nmap("<leader>lg", builtin.live_grep, {
        desc = [[
            [L]ive [G]rep.
            Search for a string in your current working directory and get results live as you type, respects .gitignore.
            (Requires ripgrep)
          ]],
      })
      km.nmap(
        "<leader>fb",
        builtin.buffers,
        { desc = "[F]ind [B]uffers. Lists open buffers in current neovim instance" }
      )
      km.nmap("<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ldfiles. Lists previously open files" })
      -- km.nmap(
      --   "<leader>fh",
      --   builtin.help_tags,
      --   {
      --     desc =
      --     "[F]ind [H]elp tags. Lists available help tags and opens a new window with the relevant help info on <cr>",
      --   }
      -- )
      km.nmap("<leader>ch", builtin.command_history, {
        desc = "[C]ommand [H]istory. Lists available help tags and opens a new window with the relevant help info on <cr>",
      })
      km.nmap(
        "<leader>fr",
        builtin.registers,
        { desc = "[F]ind [R]egisteres. Lists vim registers, pastes the contents of the register on <cr>" }
      )

      -- cf.) lua/config/plugins/lsp/keymaps.lua
      -- km.nmap("<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

      -- for file_browser
      km.nmap("<leader>e", ":Telescope file_browser<CR>", { desc = "use the telescope-file-browser" })

      -- for git
      km.nmap("<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus. Lists git status for current directory" })

      -- for emoji (nerdy)
      km.nmap("<leader>fe", ":Telescope nerdy<CR>", { desc = "[F]ind [E]moji" })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("neogen").setup()

      km.nmap("<leader>ga", ":lua require('neogen').generate()<CR>", { desc = "[G]enerate [A]nnotations" })
    end,
  },

  -- for PHP
  -- {
  --   "phpactor/phpactor",
  --   build = "composer install --no-dev --optimize-autoloader",
  --   tag = "2022.11.12",
  --   ft = "php",
  --   keys = {
  --     { "<Leader>pm", ":PhpactorContextMenu<CR>" },
  --     { "<Leader>pn", ":PhpactorClassNew<CR>" },
  --   },
  -- },

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- https://github.com/zbirenbaum/copilot-cmp
        -- w/ zbirenbaum/copilot-cmp
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    -- cf.) https://github.com/akinsho/bufferline.nvim/issues/903#issuecomment-2135155062
    -- tag = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          mode = "tabs",
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_duplicate_prefix = false,
          numbers = "ordinal",
          indicator = {
            style = "none",
          },
          color_icons = true,
          show_tab_indicators = false,
        },
        highlights = {
          buffer_selected = {
            bold = true,
            italic = true,
          },
          numbers_selected = {
            bold = true,
            italic = true,
          },
        },
      })

      -- keymaps
      km.nmap("]b", ":BufferLineCycleNext<CR>", { desc = "[G]o [t]o the next tab page" })
      km.nmap("[b", ":BufferLineCyclePrev<CR>", { desc = "[G]o [T]o the previous tab page" })
    end,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 100, -- delay: delay in milliseconds
        filetypes_denylist = {
          "markdown", -- Markdownファイルで無効化
          "NvimTree",
          "TelescopePrompt",
          "dirbuf",
          "dirvish",
          "fugitive",
          "yaml",
          "yml",
        },
      })
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local model = "gpt-4o"
      require("chatgpt").setup({
        api_key_cmd = "op read op://Personal/ChatGPT_API_for_nvim/Credentials/api-key --no-newline",
        openai_params = {
          model = model,
        },
        openai_edit_params = {
          model = model,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "stevearc/aerial.nvim",
    -- opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        -- set keymaps when aerial has attached to a buffer
        -- on_attach = function(bufnr)
        --   -- keymaps
        --   -- km.nmap("{", ":AerialPrev<CR>", {
        --   --   buffer = bufnr,
        --   --   desc = "AerialPrev",
        --   -- })
        --   -- km.nmap("}", ":AerialNext<CR>", {
        --   --   buffer = bufnr,
        --   --   desc = "AerialNext",
        --   -- })
        -- end,

        layout = {
          max_width = { 60, 0.3 },
          width = nil,
          min_width = 0.2, -- 20%
          default_direction = "prefer_right",
        },
        update_events = "BufWritePost",
      })

      -- keymaps
      km.nmap("<leader>a", ":AerialToggle!<CR>", { desc = "AerialToggle" })

      -- also be set autocmd in lua/config/autocmds.lua
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}, -- use default settings
    config = function()
      local todo_comments = require("todo-comments")
      todo_comments.setup()

      -- keymaps
      km.nmap("]t", todo_comments.jump_next, { desc = "Next todo comment" })
      km.nmap("[t", todo_comments.jump_prev, { desc = "Previous todo comment" })

      -- commands
      -- :TodoTelescope
      -- :TodoTrouble
      -- :TodoLocList
      -- :TodoQuickFix
      -- :TodoFzfLua
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
  -- temporary disabled due to cause unexpected behaviors:
  --  - forced to be folded when texts changed
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = {
  --     "kevinhwang91/promise-async",
  --   },
  --   config = function()
  --     local handler = function(virtText, lnum, endLnum, width, truncate)
  --       local newVirtText = {}
  --       local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  --       local sufWidth = vim.fn.strdisplaywidth(suffix)
  --       local targetWidth = width - sufWidth
  --       local curWidth = 0
  --       for _, chunk in ipairs(virtText) do
  --         local chunkText = chunk[1]
  --         local chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --         if targetWidth > curWidth + chunkWidth then
  --           table.insert(newVirtText, chunk)
  --         else
  --           chunkText = truncate(chunkText, targetWidth - curWidth)
  --           local hlGroup = chunk[2]
  --           table.insert(newVirtText, { chunkText, hlGroup })
  --           chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --           -- str width returned from truncate() may less than 2nd argument, need padding
  --           if curWidth + chunkWidth < targetWidth then
  --             suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
  --           end
  --           break
  --         end

  --         curWidth = curWidth + chunkWidth
  --       end

  --       table.insert(newVirtText, { suffix, "MoreMsg" })

  --       return newVirtText
  --     end

  --     local ufo = require("ufo")
  --     ufo.setup({
  --       fold_virt_text_handler = handler,
  --       -- open_fold_hl_timeout = 0,
  --       provider_selector = function(bufnr, filetype, buftype)
  --         return { "lsp", "indent" }
  --       end,
  --     })

  --     -- keymaps
  --     -- 'zR': openAllFolds
  --     -- 'zM': closeAllFolds
  --     km.nmap("zR", ufo.openAllFolds, { desc = "Open all folds" })
  --     km.nmap("zM", ufo.closeAllFolds, { desc = "Close all folds" })
  --     km.nmap("zK", function()
  --       local winid = ufo.peekFoldedLinesUnderCursor()
  --       if not winid then
  --         vim.lsp.buf.hover()
  --       end
  --     end, { desc = "Peek Fold" })
  --   end,
  -- },
  {
    "theKnightsOfRohan/csvlens.nvim",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    opts = {},

    -- keymaps
    -- H: help
  },
  {
    "godlygeek/tabular",
    fg = { "csv" },
    config = function()
      -- keymaps
      km.nmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
      km.xmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local oil = require("oil")
      oil.setup({
        delete_to_trash = true,
        keymaps = {
          ["g?"] = "actions.show_help",
        },
        view_options = {
          show_hidden = true,
        },
      })

      -- keymaps
      -- cf.) Telescope settings realise to loanch file browser
      -- for file_browser
      -- km.nmap("<leader>e", ":Telescope file_browser<CR>", { desc = "use the telescope-file-browser" })
      km.nmap("<leader>o", oil.open, { desc = "[O]pen oil browser for a directory" })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    init = function()
      require("config.plugins.codecompanion.fidget-spinner"):init()
    end,
    config = function()
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
                  -- default = "gemini-2.0-flash-001",
                  -- default = "claude-3.5-sonnet",
                  default = "claude-3.7-sonnet",
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
            slash_commands = {
              ["file"] = {
                -- Location to the slash command in CodeCompanion
                callback = "strategies.chat.slash_commands.file",
                description = "Select a file using Telescope",
                opts = {
                  provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
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
            show_settings = true, -- a yaml block will be present at the top of the chat buffer which can be modified in between responses
            -- show_header_separator = true,
            -- separator = "-",
          },
        },
        opts = {
          send_code = true, -- prevent any code from being sent to the LLM
          log_level = "INFO", -- TRACE|DEBUG|ERROR|INFO
          language = "English",
        },
      })

      -- keymaps
      km.nmap("<leader>cc", codecompanion.toggle, { desc = "[C]odecompanion toggle [C]hat window" })
      km.nmap("<C-a>", "<cmd>CodeCompanionActions<cr>")
      km.vmap("<C-a>", "<cmd>CodeCompanionActions<cr>")
    end,
  },
  {
    -- @TODO: remove in the future to use editorconfig alternatively
    -- we can add a new line at the end of the file thaks to this plugin
    "cappyzawa/trim.nvim",
    config = function()
      local trim = require("trim")
      trim.setup({
        trim_last_line = false,
        patterns = {
          [[%s/\n*\%$/\r/]],
        },
      })
    end,
  },
}

