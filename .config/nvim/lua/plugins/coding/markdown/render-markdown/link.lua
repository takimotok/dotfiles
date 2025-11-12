local M = {
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
}

return M
