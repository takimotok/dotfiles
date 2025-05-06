return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      local everforest = require("everforest")
      everforest.setup({
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

        float_style = "bright",
        inlay_hints_background = "dimmed", -- "none"` or `"dimmed"`.
        colours_override = function(palette)
          return palette
        end,
        ---@param hl Highlights
        ---@param palette Palette
        on_highlights = function(hl, palette)
          hl.CursorLineNr = { fg = palette.yellow }
        end,
      })

      everforest.load()
    end,
  },
}
