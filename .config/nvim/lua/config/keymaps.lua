-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local km = require("util.key_mapper")

km.nmap("<F2>", 'i<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.imap("<F2>", '<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.imap("<F3>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.nmap("<F4>", 'i<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })
km.imap("<F4>", '<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })

-- quit
km.nmap("<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- nohlsearch
km.nmap("<C-[><C-[>", "<cmd>nohlsearch<cr>", { desc = "Stop Highlighting" })

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

-- unmap defaults: Generals
-- cf.) https://www.lazyvim.org/keymaps
-- vim.keymap.del("n", "<leader>l") -- "lazy"

-- local function toggle_eol_display()
--   local current_listchars = vim.opt.listchars:get()
--
--   if current_listchars.eol then
--     -- Remove EOL from listchars while preserving other settings
--     current_listchars.eol = nil
--     vim.opt.listchars = current_listchars
--     print("EOL characters hidden")
--   else
--     -- Add EOL to existing listchars
--     current_listchars.eol = "↲"
--     vim.opt.listchars = current_listchars
--     -- Ensure list is enabled when showing EOL
--     vim.opt.list = true
--     print("EOL characters visible")
--   end
-- end
--
-- km.nmap("<leader>te", toggle_eol_display, { desc = "Toggle [E]OL display" })
