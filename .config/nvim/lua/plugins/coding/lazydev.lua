-- @see: https://github.com/folke/lazydev.nvim
-- properly configures LuaLS for editing our Neovim config by lazily updating our workspace libraries.
return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Load the wezterm types when the `wezterm` module is required
      -- Needs `DrKJeff16/wezterm-types` to be installed
      -- @see: plugins/coding/wezterm-types.lua
      { path = "wezterm-types", mods = { "wezterm" } },
    },
    -- disable when a .luarc.json file is found
    -- @see: https://luals.github.io/wiki/configuration/
    -- enabled = function(root_dir)
    --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    -- end,
  },
}
