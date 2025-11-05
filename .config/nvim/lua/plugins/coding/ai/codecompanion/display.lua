local M = {
  action_palette = {
    provider = "snacks", -- telescope|mini_pick|snacks|default
  },
  -- HACK: Comment out the chat table to avoi err.:
  -- ...ompanion.nvim/lua/codecompanion/strategies/chat/init.lua:337:
  -- chat = {
  --   auto_scroll = false, -- Automatically scroll down and place the cursor at the end?
  --   show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
  --   show_settings = true, -- Show LLM settings at the top of the chat buffer?
  -- },
  inline = {
    layout = "vertical", -- vertical|horizontal|buffer
  },
  diff = {
    provider = "split", -- mini_diff|split|inline
  },
}

return M
