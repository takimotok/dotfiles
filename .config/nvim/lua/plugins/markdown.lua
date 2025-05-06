local km = require("kengo.core.key_mapper")

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx", "mdc", "codecompanion" },
    opts = {
      file_types = { "markdown", "codecompanion" },

      -- https://github.com/olimorris/codecompanion.nvim/discussions/456
      render_modes = true, -- render in all modes
      sign = {
        enabled = false, -- Turn off in the status column
      },
      heading = {
        sign = false,
        -- icons = { "󰎤 ", "## ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        icons = { "# ", "## ", "### ", "󰎭 ", "󰎱 ", "󰎳 " },
        width = { "full", "full", "block", "block", "block", "block" },
        left_pad = 0,
        right_pad = 4,
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
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          web = { pattern = "^http[s]?://", icon = "🔗 ", highlight = "RenderMarkdownLink" },
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_preview_options = {
        disable_filename = 1,
      }
    end,

    -- write down one of below if TOC is needed
    -- ${toc}
    -- [[toc]]
    -- [toc]
    -- [[_toc_]]
  },
  {
    "mattn/vim-maketable",
    ft = { "markdown" },
  },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "select",
      })

      -- @TODO: couldn't show desc in which-key window w/ `km` functions
      -- keymaps
      -- Open notes associated with the selected tags.
      km.nmap("<leader>zt", "<Cmd>ZkTags<CR>", { desc = "With [Z]k-nvim, search notes by [T]ags" })

      -- Search for the notes matching a given query.
      km.nmap(
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        { desc = "With [Z]k-nvim, [F]ind notes by given queries" }
      )
    end,
  },
}
