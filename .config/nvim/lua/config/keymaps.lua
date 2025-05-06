-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local km = require("kengo.core.key_mapper")

km.nmap("<F2>", 'i<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.imap("<F2>", '<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.imap("<F3>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.nmap("<F4>", 'i<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })
km.imap("<F4>", '<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })

-- Toggle listchars visibility
km.nmap("<leader>ut", function()
  if vim.opt.list:get() then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end, { desc = "[t]oggle listchars visibility" })

-- Copy file path
km.nmap("<leader>p", ":let @+ = expand('%')<CR>", { desc = "Copy file path" })

-- unmap defaults: Move to window using the <ctrl> hjkl keys
vim.keymap.del("n", "<C-h>") -- disable "Go to Left Window"
vim.keymap.del("n", "<C-j>") -- disable "Go to Lower Window"
vim.keymap.del("n", "<C-k>") -- disable "Go to Upper Window"
vim.keymap.del("n", "<C-l>") -- disable "Go to Right Window"

-- unmap defaults: Resize window using <ctrl> arrow keys
vim.keymap.del("n", "<C-Up>") -- disable "Increase Window Height"
vim.keymap.del("n", "<C-Down>") -- disable "Decrease Window Height"
vim.keymap.del("n", "<C-Left>") -- disable "Decrease Window Width"
vim.keymap.del("n", "<C-Right>") -- disable "Increase Window Width"
