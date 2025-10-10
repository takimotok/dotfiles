local km = require("kengo.core.key_mapper")

return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "HakonHarnes/img-clip.nvim",
    },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      keymaps = {
        ["g?"] = "actions.show_help",
        -- @TODO: show an image preview w/ img-clip
        -- ["<C-p>"] = {
        --   function()
        --     -- local oil = require("oil")
        --     -- local filename = oil.get_cursor_entry().name
        --     -- local dir = oil.get_current_dir()
        --     -- oil.close()
        --     --
        --     -- img_clip.paste_image({}, dir .. filename)
        --   end,
        --   mode = "n",
        --   nowait = true,
        --   desc = "Open/Close the preview window under the cursor",
        -- },
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
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
      "stevearc/oil.nvim",
    },
    keys = {
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    config = function(_, opts)
      -- set options
      -- -----
      -- file and directory options
      local xdg_cache_home = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")
      local image_cache_path = xdg_cache_home .. "/" .. "nvim" .. "/" .. "images"

      if vim.fn.isdirectory(image_cache_path) == 0 then
        vim.fn.mkdir(image_cache_path, "p")
      end

      opts.dir_path = image_cache_path
      opts.file_name = "%y%m%d_%H%M%S"
      opts.use_absolute_path = true
      opts.filetypes = {
        codecompanion = {
          -- file and directory options
          dir_path = image_cache_path,
          file_name = "%y%m%d_%H%M%S",
          use_absolute_path = true,

          -- template options
          template = "[Image]($FILE_PATH)",

          -- prompt options
          prompt_for_file_name = false,
        },
      }

      local img_clip = require("img-clip")
      img_clip.setup(opts)

      -- @TODO: Cooperate w/ snacks.nvim
      -- keybind w/ snacks.nvim
      -- local Snacks = require("snacks")
      -- Snacks.picker.files({
      --   ft = { "jpg", "jpeg", "png", "webp" },
      --   confirm = function(self, item, _)
      --     self:close()
      --     require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
      --   end,
      -- })

      -- other commands:
      -- @see: https://github.com/hakonharnes/img-clip.nvim?tab=readme-ov-file
      --
      -- PasteImage: Pastes an image from the system clipboard
      -- ImgClipDebug: Prints the debug log, including the output of shell commands
      -- ImgClipConfig: Prints the current configuration
    end,
  },
}
