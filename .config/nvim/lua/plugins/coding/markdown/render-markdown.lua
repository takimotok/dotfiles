local km = require("util.key_mapper")
local md_filetypes = require("util").md_filetypes

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = md_filetypes,
  opts = {
    file_types = md_filetypes,

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
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note: ", highlight = "RenderMarkdownInfo" },
      memo = { raw = "[!MEMO]", rendered = "📝 Memo: ", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip: ", highlight = "RenderMarkdownSuccess" },
      info = { raw = "[!INFO]", rendered = "󰋽 Info: ", highlight = "RenderMarkdownInfo" },
      todo = { raw = "[!TODO]", rendered = "󰗡 Todo: ", highlight = "RenderMarkdownInfo" },
      question = { raw = "[!Q]", rendered = "󰘥 Q.: ", highlight = "RenderMarkdownWarn" },
      quote = { raw = "[!QUOTE]", rendered = "󱆨 ", highlight = "RenderMarkdownQuote" },
    },
    bullet = {
      enabled = true,
      icons = { "○", "○", "○", "○" },
      left_pad = 0,
      right_pad = 0,
      highlight = "RenderMarkdownBullet",
    },
    checkbox = {
      enabled = true,
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
    latex = { enabled = false },
  },
  config = function(_, opts)
    local rm = require("render-markdown")
    rm.setup(opts)

    -- key mappings
    km.nmap("<leader>um", function()
      rm.buf_toggle()
    end, { desc = "Toggle RenderMarkdown" })
  end,
}
