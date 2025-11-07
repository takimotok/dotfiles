return {
  "brenoprata10/nvim-highlight-colors",
  cmd = {
    "HighlightColors On",
    "HighlightColors Off",
    "HighlightColors Toggle",
    "HighlightColors IsActive",
  },
  -- disable on start up
  init = function()
    local nhc = require("nvim-highlight-colors")

    if nhc.is_active() then
      nhc.turnOff()
    end
  end,
  keys = {
    { "<leader>uc", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle Colors" },
  },
  opts = {
    enable_tailwind = true, ---Highlight tailwind colors, e.g. 'bg-blue-500'
  },
}
