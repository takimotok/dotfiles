return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize_kb = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize_kb then
            return true
          end
        end,
      },
      indent = {
        enable = true,
      },
      -- do NOT enable fold due to bad behaviors
      -- fold = {
      --   enable = true,
      -- },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["ic"] = "@comment.inner",
            ["ac"] = "@comment.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["im"] = "@class.inner",
            ["am"] = "@class.outer",
            ["ib"] = "@block.inner",
            ["ab"] = "@block.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            ["]]"] = "@function.outer",
          },
          goto_next_end = {
            ["]["] = "@function.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
          },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<C-p>",
        },
      },
    })
  end,
}
