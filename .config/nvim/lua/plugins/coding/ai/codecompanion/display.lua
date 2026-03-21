local M = {
  action_palette = {
    provider = "snacks", -- telescope|mini_pick|snacks|default
  },
  chat = {
    icons = {
      chat_context = "📎️",
      tool_success = "󰸞 ",
    },
    intro_message = "",
    -- auto_scroll = true, -- Automatically scroll down and place the cursor at the end
    show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
    show_settings = false, -- Show LLM settings at the top of the chat buffer
    fold_context = false, -- Fold context in the chat buffer?
  },
  diff = {
    enabled = true,
    word_highlights = {
      additions = true,
      deletions = true,
    },
  },
}

return M
