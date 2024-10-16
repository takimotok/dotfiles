return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  opts = {
    -- "soft", "medium" or "hard".
    background = "hard",
    -- (e.g.) status line background
    transparent_background_level = 2,
    italics = true,
    disable_italic_comments = false,
    sign_column_background = "none",
    -- `"high"` or `"low"` (default).
    ui_contrast = "high",
    dim_inactive_windows = false,
    diagnostic_text_highlight = false,
    diagnostic_virtual_text = "coloured",
    diagnostic_line_highlight = false,
    spell_foreground = false,
    show_eob = true,
    -- inlay_hints_background = "dimmed", -- "none"` or `"dimmed"`.
  },
  config = function(_, opts)
    local everforest = require("everforest")
    everforest.setup(opts)
    everforest.load()
  end,
}
