-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Prepend mise shims to PATH
-- vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- backup, swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- disable mouse
vim.o.mouse = ""

-- Text area
-- vim.opt.textwidth = 150
vim.opt.showtabline = 1
vim.opt.wrap = true
vim.opt.spelllang = "en_us,cjk"

-- show <Tab> and <EOL>
-- vim.opt.list = true
vim.opt.listchars = {
  tab = "▸-",
  -- trail = " -",
  nbsp = "+",
  space = "⋅",
  -- eol = "↲",
  --   extends = "»",
  --   precedes = "«",
}

-- command history
vim.opt.history = 512

-- @TODO: could not work foldings
-- foldings
-- vim.o.foldtext = ""
-- vim.o.foldcolumn = "0"
-- vim.o.foldenable = true
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldnestmax = 5 -- Only fold up to this many nested levels.
-- vim.o.foldminlines = 1 -- Only fold if there are at least this many lines.
