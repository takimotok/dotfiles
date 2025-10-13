local km = require("util.key_mapper")

return {
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
}
