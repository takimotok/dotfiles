local M = {
  enabled = true,
  unchecked = {
    icon = "[ ]",
    highlight = "RenderMarkdownUnchecked",
    scope_highlight = nil,
  },
  checked = {
    icon = "✅",
    highlight = "RenderMarkdownChecked",
    scope_highlight = "@markup.strikethrough",
  },
-- stylua: ignore
  custom = {
    todo      = { raw = "[-]", rendered = "🕛", highlight = "RenderMarkdownTodo", scope_highlight = nil },
    important = { raw = "[~]", rendered = "🌟", highlight = "RenderMarkdownWarn"    , scope_highlight = nil },
  },
}

return M
