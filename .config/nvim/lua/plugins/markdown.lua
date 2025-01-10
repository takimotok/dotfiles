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
        { desc = "With [Z]k-nvim, [F]search notes by given queries" }
      )

      -- Search for the notes matching the current visual selection.
      km.vmap(
        "<leader>zf",
        ":'<,'>ZkMatch<CR>",
        { desc = "With [Z]k-nvim, [F]search notes in selection by given queries" }
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
      local vaultPath = "~/takimoto.kengo@gmail.com - Google Drive/My Drive/Vault"
      require("telekasten").setup({
        home = vim.fn.expand(vaultPath),
        image_subdir = "images",
        follow_creates_nonexisting = false,
        dailies_create_nonexisting = false,
        weeklies_create_nonexisting = false,
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
    end,
  },
}
