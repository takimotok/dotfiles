local config_snacks_piker = require("kengo.config.plugins.ui.snacks_picker")

return {
  {
    "snacks.nvim",
    opts = {
      notifier = {
        enabled = true,
        timeout = 5000, -- ms
      },
      indent = {
        enabled = true,
      },
      explorer = {
        enabled = true,
        show_hidden = true,
      },
      picker = {
        -- enter = false,
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
      },

      dashboard = {
        preset = {
          header = config_snacks_piker.set_logo(),
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "30%",
                col = "50%",
              },
            },
          },
        },
      },
    },
  },
}
