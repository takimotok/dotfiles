return {
  "zbirenbaum/copilot.lua",
  lazy = true,
  event = "InsertEnter",
  config = function()
    -- NOTE: Avoid interfering with completions properly appearing in `blink-cmp-copilot`
    -- to disable copilot.lua's suggestion and panel modules.
    -- @see: https://github.com/giuxtaposition/blink-cmp-copilot
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
