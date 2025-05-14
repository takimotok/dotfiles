km = require("kengo.core.key_mapper")

return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      keymaps = {
        ["g?"] = "actions.show_help",
      },
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      km.nmap("<leader>o", function()
        require("oil").open()
      end, { desc = "[O]pen Oil browser" })
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function(_, opts)
      require("aerial").setup(opts)

      -- Set Everforest colors for aerial after the theme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "everforest",
        callback = function()
          -- Basic aerial highlight groups
          vim.api.nvim_set_hl(0, "AerialLine", { link = "CursorLine" })
          vim.api.nvim_set_hl(0, "AerialLineNC", { link = "Visual" })
          vim.api.nvim_set_hl(0, "AerialGuide", { link = "Comment" })

          -- Symbol kind highlights using Everforest palette
          vim.api.nvim_set_hl(0, "AerialClassIcon", { fg = "#a7c080" }) -- green
          vim.api.nvim_set_hl(0, "AerialClass", { link = "Type" })
          vim.api.nvim_set_hl(0, "AerialFunctionIcon", { fg = "#e67e80" }) -- red
          vim.api.nvim_set_hl(0, "AerialFunction", { link = "Function" })
          vim.api.nvim_set_hl(0, "AerialMethodIcon", { fg = "#d699b6" }) -- purple
          vim.api.nvim_set_hl(0, "AerialMethod", { link = "Function" })
          vim.api.nvim_set_hl(0, "AerialStructIcon", { fg = "#83c092" }) -- cyan
          vim.api.nvim_set_hl(0, "AerialStruct", { link = "Type" })
          vim.api.nvim_set_hl(0, "AerialEnumIcon", { fg = "#dbbc7f" }) -- yellow
          vim.api.nvim_set_hl(0, "AerialEnum", { link = "Type" })
          vim.api.nvim_set_hl(0, "AerialModuleIcon", { fg = "#7fbbb3" }) -- aqua
          vim.api.nvim_set_hl(0, "AerialModule", { link = "Include" })
          vim.api.nvim_set_hl(0, "AerialInterfaceIcon", { fg = "#d699b6" }) -- purple
          vim.api.nvim_set_hl(0, "AerialInterface", { link = "Type" })
          vim.api.nvim_set_hl(0, "AerialConstructorIcon", { fg = "#e69875" }) -- orange
          vim.api.nvim_set_hl(0, "AerialConstructor", { link = "Function" })
        end,
      })

      -- Trigger the autocmd immediately if Everforest is current colorscheme
      if vim.g.colors_name == "everforest" then
        vim.cmd("doautocmd ColorScheme everforest")
      end
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "folke/snacks.nvim", -- optional
    },
    cmd = {
      "Neogen",
      "Neogit",
      "NeogitCommit",
      "NeogitLogCurrent",
      "NeogitResetState",
    },
    opts = {
      auto_refresh = true,
      kind = "tab",
      commit_popup = {
        kind = "vsplit",
      },
      preview_buffer = {
        kind = "vsplit",
      },
      popup = {
        kind = "vsplit",
      },
      integrations = {
        diffview = true,
        -- snacks = true,
      },
    },
  },
  {
    "keaising/im-select.nvim",
    event = { "InsertEnter" },
    opts = {
      default_im_select = "com.google.inputmethod.Japanese.Roman",
      default_command = "macism",
      set_previous_events = {},
    },
  },
}
