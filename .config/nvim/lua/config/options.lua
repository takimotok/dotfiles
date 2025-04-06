-- [[ Setting options ]]
-- @see `:h vim.opt`
-- @see `:h option-list`

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- encoding
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"
-- 下記を指定すると err. で落ちる
-- vim.opt.fileencoding = "utf-8"

-- backup, swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- Color scheme
-- NOTE: make sure the terminal supports this
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Search
vim.opt.hlsearch = true
vim.opt.matchtime = 1

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- netrw
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- mouse
vim.opt.mouse = "a"

-- clipboard
-- @see `:h 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- indentations
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- tabstops
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- show <Tab> and <EOL>
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸-",
  trail = "-",
  nbsp = "+",
  -- eol = "↲",
  space = "⋅",
  --   extends = "»",
  --   precedes = "«",
}
-- vim.opt.fillchars = {
--   eob = "~", -- 空行を表示
-- }

-- command history
vim.opt.history = 512

-- Save undo history
-- vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- working directories
-- vim.opt.autochdir = true

-- buffers
vim.opt.splitright = true
vim.opt.hidden = true

-- Text area
vim.opt.textwidth = 150
vim.opt.wrap = true
vim.opt.showtabline = 1
vim.opt.visualbell = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.winblend = 30 -- pseudo-transparency for a floating window
vim.opt.pumblend = 10 -- pseudo-transparency for the popup-menu
vim.opt.conceallevel = 0 -- hide url links in buffers

vim.opt.spelllang = "en_us,cjk"

-- @TODO: disable the newline continuation of comments
-- seems not work
-- vim.opt.formatoptions = "tqj"
--

-- foldings
vim.o.foldcolumn = "0"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 5 -- Only fold up to this many nested levels.
vim.o.foldminlines = 1 -- Only fold if there are at least this many lines.
-- temporary disabled these settings for treesitter folding function
-- vim.wo.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"

-- status line
vim.opt.laststatus = 2

-- last line (under the status line)
vim.opt.showmode = false

-- Decrease update time
vim.o.updatetime = 250
-- vim.o.timeout = true
vim.o.timeoutlen = 300

-- completion
vim.opt.completeopt = "menuone,noinsert,noselect"

-- python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = vim.env.MISE_DATA_DIR .. "/installs/python/3/bin/python"

-- file format and line endings
-- vim.opt.endofline = true             -- ファイル末尾の改行を保持
vim.opt.fileformat = "unix" -- デフォルトの改行コード
vim.opt.fileformats = "unix,mac,dos" -- 優先順位付きの改行コード
vim.opt.fixendofline = false -- ファイル末尾の改行を自動的に追加
-- vim.opt.binary = true
-- vim.opt.nofixeol= true

-- 仮想行の表示設定
-- vim.opt.virtualedit = "block"        -- visual-blockモードで仮想編集を有効化
-- vim.opt.display = "lastline,msgsep"  -- 長い行の表示方法を制御
-- vim.opt.display = "lastline"  -- 長い行の表示方法を制御

-- @TODO: think later
-- @see `:h modeline`
-- vim: ts=2 sts=2 sw=2 et

