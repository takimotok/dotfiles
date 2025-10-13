return {
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
}
