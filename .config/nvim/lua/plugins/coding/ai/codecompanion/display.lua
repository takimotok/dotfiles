local M = {
  action_palette = {
    provider = "snacks", -- telescope|mini_pick|snacks|default
  },
  -- HACK: We can NOT be allowed using spaces into `strategies.chat.roles.user`.
  -- We'll get an error in `display.chat` senction under the condition above.
  -- @see: https://github.com/olimorris/codecompanion.nvim/issues/1067#issuecomment-2700520015
  chat = {
    icons = {
      tool_success = "󰸞 ",
    },

    -- auto_scroll = true, -- Automatically scroll down and place the cursor at the end
    show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
    -- HACK: Turn off `show_settings`. We get an error if set `show_settings = true`
    -- To avoid it, specify `choices` to `adapters.http.copilot.schema.model` in
    -- `plugins.coding.ai.codecompanion.adapters.lua`.
    show_settings = true, -- Show LLM settings at the top of the chat buffer
    fold_context = false, -- Fold context in the chat buffer?
  },
  diff = {
    provider = "split", -- mini_diff|split|inline
  },
}

return M
