return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
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
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
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
    })
  end,
}
