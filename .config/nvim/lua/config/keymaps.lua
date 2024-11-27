-- [[ Basic Keymaps ]]
local km = require("core.key_mapper")

-- add date
km.nmap("<F2>", 'i<C-R>=strftime("%H:%M:%S")<CR>', { desc = "insert time" })
km.imap("<F2>", '<C-R>=strftime("%H:%M:%S")<CR>', { desc = "insert time" })
km.nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.imap("<F3>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })

-- stop the hilighting
km.nmap("<ESC><ESC>", "<CMD>nohlsearch<CR>", { desc = "Unhighlight" })

-- Escape
km.imap("jk", "<ESC>", { desc = "leave insert mode" })
