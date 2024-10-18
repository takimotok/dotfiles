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
      show_end_of_line = true,
      space_char_blankline = " ",
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
            "node_modules",
            "build",
            "dist",
            "yarn.lock",
            "composer.lock",
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

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")

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
      km.nmap("<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

      -- for file_browser
      km.nmap("<leader>e", ":Telescope file_browser<CR>", { desc = "use the telescope-file-browser" })

      -- for git
      km.nmap("<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus. Lists git status for current directory" })
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
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- require("mini").setup()
      require("mini.align").setup()
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local model = "gpt-4o-2024-05-13"
      require("chatgpt").setup({
        api_key_cmd = "op read op://Personal/ChatGPT_API/Credentials/api-key --no-newline",
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
}
