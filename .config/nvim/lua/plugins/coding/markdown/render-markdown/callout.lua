local M = {
  note = { raw = "[!NOTE]", rendered = "󰋽 Note: ", highlight = "RenderMarkdownInfo" },
  memo = { raw = "[!MEMO]", rendered = "📝 Memo: ", highlight = "RenderMarkdownInfo" },
  tip = { raw = "[!TIP]", rendered = "󰌶 Tip: ", highlight = "RenderMarkdownSuccess" },
  info = { raw = "[!INFO]", rendered = "󰋽 Info: ", highlight = "RenderMarkdownInfo" },
  todo = { raw = "[!TODO]", rendered = "󰗡 Todo: ", highlight = "RenderMarkdownInfo" },
  question = { raw = "[!Q]", rendered = "󰘥 Q.: ", highlight = "RenderMarkdownWarn" },
  quote = { raw = "[!QUOTE]", rendered = "󱆨 ", highlight = "RenderMarkdownQuote" },
}

return M
