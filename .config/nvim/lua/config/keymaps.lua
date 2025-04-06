-- [[ Basic Keymaps ]]
local km = require("core.key_mapper")

-- add date
km.nmap("<F2>", 'i<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.imap("<F2>", '<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.imap("<F3>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.nmap("<F4>", 'i<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })
km.imap("<F4>", '<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })

-- stop the hilighting
km.nmap("<ESC><ESC>", "<CMD>nohlsearch<CR>", { desc = "Unhighlight" })

-- Escape
km.imap("jk", "<ESC>", { desc = "leave insert mode" })

-- Toggle listchars visibility
km.nmap("<leader>lt", function()
  if vim.opt.list:get() then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end, { desc = "[L]istchars Toggle visibility" })

