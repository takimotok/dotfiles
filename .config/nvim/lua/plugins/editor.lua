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
      -- @TODO: toggle below
      -- vim.opt.listchars:append "space:⋅"

      -- keymaps
      km.nmap(
        "<leader>ti",
        ":IndentBlanklineToggle<CR>",
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
        desc =
        "[C]ommand [H]istory. Lists available help tags and opens a new window with the relevant help info on <cr>",
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
  -- {
  --   'lambdalisue/fern.vim',
  --   dependencies = {
  --     'lambdalisue/nerdfont.vim',
  --     'lambdalisue/fern-git-status.vim',
  --     'lambdalisue/fern-renderer-nerdfont.vim',
  --   },
  --   config = function()
  --     -- icons
  --     vim.g['fern#renderer'] = 'nerdfont'

  --     -- keymaps
  --     km.nmap('<leader>e', '<cmd>Fern . -reveal=% -drawer<cr>', { desc = 'Open file tree as project drawer style' })
  --   end,
  -- },
  {
    "kosayoda/nvim-lightbulb",
    event = { "LspAttach" },
    opts = function()
      return {
        autocmd = {
          enabled = false,
          events = { "CursorHold", "CursorHoldI" },
          pattern = { "*" },
        },
        sign = { enabled = false },
        virtual_text = { enabled = true },
        ignore = {
          ft = { "markdown" },
        },
      }
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
  {
    "phpactor/phpactor",
    build = "composer install --no-dev --optimize-autoloader",
    ft = "php",
    keys = {
      { "<Leader>pm", ":PhpactorContextMenu<CR>" },
      { "<Leader>pn", ":PhpactorClassNew<CR>" },
    },
  },

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      -- local font_color = "#1E2326"
      -- local bg_color = "#D3C6AA"
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
            -- fg = font_color,
            -- bg = bg_color,
            bold = true,
            italic = true,
          },
          numbers_selected = {
            -- fg = font_color,
            -- bg = bg_color,
            bold = true,
            italic = true,
          },
          -- tab_selected = {
          --   fg = font_color,
          --   bg = bg_color,
          -- },
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
}
