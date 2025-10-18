require("config.options")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Note: `import` searches `init.lua` recursively under the child directory.
    -- so be careful to make the file names
    { import = "plugins.editor" },
    { import = "plugins.ui" },
    { import = "plugins.coding" },
    { import = "plugins.coding.ai" },
    { import = "plugins.coding.markdown" },
    { import = "plugins.lsp" },
    { import = "plugins.formatting" },
    { import = "plugins.linting" },
    -- { import = "plugins.snippets" },
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
    frequency = 86400, -- check once per day [sec.]
  },
  -- install missing plugins on startup
  install = {
    colorscheme = { "everforest" },
  },
  ui = {
    border = "single",
    -- icons = {},
  },
  -- automatically check for config file changes and reload the ui
  change_detection = {
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load functions next as our plugins and autocmds require them
-- require("config.functions")
require("config.autocmds")

-- Autocmds and keymaps can be loaded, lazily, after plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("util")
    require("config.autocmds")
    require("config.keymaps")
  end,
})
