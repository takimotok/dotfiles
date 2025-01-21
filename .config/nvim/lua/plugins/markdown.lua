local km = require("core.key_mapper")

return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        disable_filename = 1,
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    build = ":call mkdp#util#install()",

    -- write down one of below if TOC is needed
    -- ${toc}
    -- [[toc]]
    -- [toc]
    -- [[_toc_]]
  },
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = {
      "godlygeek/tabular",
    },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_auto_insert_bullets = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_edit_url_in = "tab"
      -- vim.g.vim_markdown_fenced_languages = {
      --   'bash=bash',
      --   'js=javascript',
      --   'ts=javascript',
      --   'sh=zsh',
      --   'py=python',
      --   'java'
      -- }
      -- keymaps
      -- h.nmap('<leader>gx', '<Plug>Markdown_OpenUrlUnderCursor<cr>',
      --   { desc = 'open the link under the cursor in the same browser as the standard gx command.' })
    end,
  },
  {
    "mattn/vim-maketable",
    ft = { "markdown" },
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      -- vim.g.table_mode_corner_corner = "+"
      -- vim.g.table_mode_header_fillchar = "="
      vim.g.table_mode_delimiter = ","
    end,
    -- :TableModeToggle mapped to <Leader>tm by default
    -- @see: https://github.com/dhruvasagar/vim-table-mode#creating-table-on-the-fly
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({
        heading = {
          sign = false,
          icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
          width = { "full", "full", "block", "block", "block", "block" },
        },
        -- callout = {
        --   note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        --   tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        --   tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
        --   info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
        --   todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
        --   question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
        --   fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
        --   example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
        --   quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
        -- },
        bullet = {
          enabled = true,
          icons = { "○", "○", "○", "○" },
          left_pad = 0,
          right_pad = 0,
          highlight = "RenderMarkdownBullet",
        },
        checkbox = {
          enabled = true,
          position = "inline",
          unchecked = {
            icon = "[ ] ",
            highlight = "RenderMarkdownUnchecked",
            scope_highlight = nil,
          },
          checked = {
            icon = "✅ ",
            highlight = "RenderMarkdownChecked",
            scope_highlight = nil,
          },
          custom = {
            todo = { raw = "[-]", rendered = "🕛 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
            important = { raw = "[~]", rendered = "🌟 ", highlight = "DiagnosticWarn" },
          },
        },
        code = {
          sign = false,
          width = "block",
          position = "right",
          left_pad = 2,
          right_pad = 2,
        },
        pipe_table = { preset = "round" },
        link = {
          enabled = true,
          image = " ",
          email = "📧 ",
          hyperlink = "🔗 ",
          highlight = "RenderMarkdownLink",
          wiki = { icon = "🔗 ", highlight = "RenderMarkdownWikiLink" },
          custom = {
            web = { pattern = "^http[s]?://", icon = "🔗 ", highlight = "RenderMarkdownLink" },
          },
        },
      })

      -- keymaps
      km.nmap("<leader>m", ":RenderMarkdown toggle<CR>", { desc = "[R]ender Markdown Toggle" })
    end,
  },
  -- {
  --   "3rd/image.nvim",
  --   dependencies = {
  --     "leafo/magick",
  --   },
  --   opts = {},
  --   config = function()
  --     local image = require("image")
  --     image.setup({
  --       backend = "kitty",
  --       integrations = {
  --         markdown = {
  --           enabled = true,
  --           only_render_image_at_cursor = true,
  --           filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
  --         },
  --         neorg = {
  --           enabled = true,
  --           only_render_image_at_cursor = true,
  --           filetypes = { "norg" },
  --         },
  --       },
  --       max_width_window_percentage = 60,
  --       max_height_window_percentage = 40,
  --       -- hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  --     })
  --   end,
  -- },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({})

      -- keymaps
      -- Open notes associated with the selected tags.
      km.nmap("<leader>zt", "<Cmd>ZkTags<CR>", { desc = "With [Z]k-nvim, search notes by [T]ags" })

      -- Search for the notes matching a given query.
      km.nmap(
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        { desc = "With [Z]k-nvim, [F]ind notes by given queries" }
      )

      -- Search for the notes matching the current visual selection.
      km.vmap(
        "<leader>zm",
        ":'<,'>ZkMatch<CR>",
        { desc = "With [Z]k-nvim, search notes [M]atching the current visual selection" }
      )
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-telekasten/calendar-vim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      local notePath = vim.env.NOTES

      -- Common date format specifiers:
      -- - `%Y`: Year with century (2024)
      -- - `%m`: Month as number (01-12)
      -- - `%d`: Day of the month (01-31)
      -- - `%H`: Hour (00-23)
      -- - `%M`: Minute (00-59)
      -- - `%S`: Second (00-59)
      local year = os.date("%Y")
      local month = os.date("%m")
      local day = os.date("%d")

      require("telekasten").setup({
        home = vim.fn.expand(notePath),
        dailies = vim.fn.expand(notePath .. "/journal/dailies/" .. year .. "/" .. month),
        weeklies = vim.fn.expand(notePath .. "/journal/weeklies/" .. year),
        follow_creates_nonexisting = false,
        dailies_create_nonexisting = false,
        weeklies_create_nonexisting = false,
        new_note_filename = "uuid-title",
        uuid_type = "%Y%m%d%H%M%S",
        uuid_sep = "_",
        filename_space_subst = "_",
        filename_small_case = true,
        template_new_note = vim.fn.expand(vim.env.XDG_CONFIG_HOME .. "/zk/templates/default.md"),
        template_new_daily = vim.fn.expand(vim.env.XDG_CONFIG_HOME .. "/zk/templates/default.md"),
        template_new_weekly = vim.fn.expand(vim.env.XDG_CONFIG_HOME .. "/zk/templates/default.md"),
        tag_notation = "#tag", -- #tag, @tag, :tag:, yaml-bare
        new_note_location = "prefer_home",
        enable_create_new = false,
        image_link_style = "markdown",
        sort = "modified",
        media_previewer = "telescope-media-files",
        media_extensions = {
          ".png",
          ".jpg",
          ".svg",
          ".bmp",
          ".gif",
          ".pdf",
          ".mp4",
          ".webm",
          ".webp",
        },
      })

      -- -- Most used functions
      -- vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
      -- vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
      -- vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
      -- vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
      -- vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
      -- vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
      -- vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
      --
      -- -- Call insert link automatically when we start typing a link
      -- vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

      -- km.nmap(
      --   "<leader>zs",
      --   "<Cmd>Telekasten search_notes<CR>",
      --   { desc = "live grep with the word under the cursor via Telekasten, [S]earch notes via Telescope live grep" }
      -- )

      -- Launch panel if nothing is typed after <leader>z
      km.nmap("<leader>z", "<Cmd>Telekasten panel<CR>", { desc = "Launch panel if nothing is typed after <leader>z" })

      km.nmap("<leader>zc", "<Cmd>Telekasten show_calendar<CR>", { desc = "With Telekasten, show [C]alendar" })
    end,
  },
}
