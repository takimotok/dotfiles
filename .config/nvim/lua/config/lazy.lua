require("core.plugin").init()

local lazy = require("lazy")

if vim.env.NVIM_COLORSCHEME == nil then
  -- vim.env.NVIM_COLORSCHEME = "catppuccin"
  -- vim.env.NVIM_COLORSCHEME = "zenbones"
  vim.env.NVIM_COLORSCHEME = "everforest"
end

lazy.setup("plugins", {
  install = {
    missing = true,
    colorscheme = { vim.env.NVIM_COLORSCHEME },
  },
  checker = { enabled = true },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
})
