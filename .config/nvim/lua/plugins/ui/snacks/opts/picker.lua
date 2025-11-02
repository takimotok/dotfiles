local M = {}

M = {
  enabled = true,
  layout = {
    cycle = true,
    -- Use the default layout or vertical if the window is too narrow
    -- cf.) https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
    preset = function()
      return vim.o.columns >= 120 and "default" or "vertical"
    end,
  },

  -- result list window
  sources = {
    files = {
      hidden = true,
    },
    explorer = {
      hidden = true,
    },
    notifications = {
      layout = {
        -- Override specific dimensions
        preset = "vertical",

        -- Override to put preview on top and list on bottom
        layout = {
          width = 0.8,
          height = 0.8,
        },
      },
      confirm = { "copy", "close" },
    },
  },

  formatters = {
    file = {
      truncate = 80, -- truncate the file path to (roughly) this length
    },
  },
}

return M
