---
description: "Neovim 設定ファイル（config/）用のガイドライン"
applyTo: "**/config/*.lua"
---

# Neovim 設定ファイル ガイドライン

## ファイル構成

### 各設定ファイルの役割
- `options.lua`: Neovimの基本オプション設定
- `keymaps.lua`: キーマップ定義
- `autocmds.lua`: オートコマンド定義
- `lazy.lua`: プラグインマネージャー設定

## オプション設定 (options.lua)

### 推奨パターン
```lua
-- vim.opt を使用した設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- テーブル形式での設定
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "☠",
}
```

### 設定のグループ化
```lua
-- 表示関連
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- インデント関連
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- 検索関連
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
```

## キーマップ設定 (keymaps.lua)

### 基本パターン
```lua
local map = vim.keymap.set

-- 基本的なキーマップ
map("n", "<leader>w", "<cmd>w<cr>", { desc = "ファイルを保存" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "終了" })

-- 関数呼び出し
map("n", "<leader>l", function()
  vim.cmd("Lazy")
end, { desc = "Lazy UI を開く" })

-- 複数モード
map({ "n", "v" }, "<leader>y", '"+y', { desc = "システムクリップボードにコピー" })

-- バッファローカル
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf
    map("n", "gd", vim.lsp.buf.definition, { desc = "定義へジャンプ", buffer = buffer })
  end,
})
```

### キーマップの整理
```lua
-- リーダーキーのグループ化
-- <leader>f - Find/Search
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "ファイル検索" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "テキスト検索" })

-- <leader>b - Buffer
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "バッファを削除" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "次のバッファ" })

-- <leader>w - Window
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "垂直分割" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "水平分割" })
```

## オートコマンド設定 (autocmds.lua)

### 基本パターン
```lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- グループ作成
local general_group = augroup("General", { clear = true })

-- ファイル保存時の自動フォーマット
autocmd("BufWritePre", {
  group = general_group,
  pattern = "*",
  callback = function()
    -- 末尾の空白削除
    vim.cmd([[%s/\s\+$//e]])
  end,
  desc = "末尾の空白を削除",
})

-- ファイルタイプ固有の設定
autocmd("FileType", {
  group = general_group,
  pattern = { "lua", "javascript", "typescript" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "特定ファイルタイプのインデント設定",
})
```

### LSP関連のオートコマンド
```lua
local lsp_group = augroup("LspConfig", { clear = true })

autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buffer = args.buf
    
    -- LSP固有のキーマップ
    if client.server_capabilities.definitionProvider then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer })
    end
  end,
})
```

## lazy.lua の設定

### プラグインマネージャー設定
```lua
require("lazy").setup({
  spec = {
    -- LazyVim本体
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    
    -- カスタムプラグイン設定をインポート
    { import = "plugins" },
  },
  
  defaults = {
    lazy = false,
    version = false, -- 最新版を使用
  },
  
  performance = {
    rtp = {
      -- 不要なプラグインを無効化
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```

## エラーハンドリング

### 安全なrequire
```lua
local ok, module = pcall(require, "module-name")
if not ok then
  vim.notify("モジュールの読み込みに失敗: " .. module, vim.log.levels.ERROR)
  return
end
```

### 設定の検証
```lua
-- 必要なコマンドの存在確認
if vim.fn.executable("ripgrep") == 0 then
  vim.notify("ripgrepがインストールされていません", vim.log.levels.WARN)
end

-- 機能の存在確認
if vim.fn.has("nvim-0.9") == 0 then
  vim.notify("Neovim 0.9以上が必要です", vim.log.levels.ERROR)
  return
end
```

## パフォーマンス最適化

### 遅延読み込み
```lua
-- 重い処理は遅延実行
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    -- Neovim起動後に実行したい処理
  end,
})
```

### 条件付き設定
```lua
-- 特定の条件下でのみ設定を適用
if vim.g.vscode then
  -- VS Code Neovim拡張用の設定
  return
end

-- GUI環境でのみ適用
if vim.g.neovide then
  vim.opt.guifont = "JetBrains Mono:h12"
end
```