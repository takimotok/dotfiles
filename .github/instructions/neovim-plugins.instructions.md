---
description: "Neovim プラグイン設定用のガイドライン"
applyTo: "**/plugins/*.lua"
---

# Neovim プラグイン設定ガイドライン

## LazyVim プラグイン設定の基本構造

### 標準的なプラグイン設定
```lua
return {
  "author/plugin-name",
  
  -- 依存関係
  dependencies = {
    "dependency1/repo",
    "dependency2/repo",
  },
  
  -- 読み込みタイミング
  event = "VeryLazy", -- または "BufReadPre", "InsertEnter" など
  -- cmd = "CommandName", -- コマンド実行時
  -- ft = "filetype", -- ファイルタイプ固有
  
  -- プラグイン設定
  opts = {
    -- プラグイン固有のオプション
  },
  
  -- カスタム設定が必要な場合
  config = function(_, opts)
    require("plugin-name").setup(opts)
    -- 追加のカスタム設定
  end,
  
  -- キーマップ
  keys = {
    { "<leader>x", function() require("plugin-name").action() end, desc = "アクションの説明" },
  },
}
```

## 推奨パターン

### ファイル分割
- 機能別にプラグイン設定ファイルを分割
- 例: `lsp.lua`, `editor.lua`, `ui.lua`, `formatting.lua`

### 設定の優先順位
1. `opts` テーブルでの設定（推奨）
2. `config` 関数での設定（必要時のみ）

### キーマップの定義
```lua
keys = {
  -- 基本的なキーマップ
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "ファイルを検索" },
  
  -- 関数呼び出し
  { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "テキストを検索" },
  
  -- モード指定
  { "<leader>v", "<cmd>vsplit<cr>", desc = "垂直分割", mode = "n" },
  
  -- バッファ固有
  { "gd", vim.lsp.buf.definition, desc = "定義へジャンプ", buffer = true },
}
```

### 条件付き設定
```lua
return {
  "plugin/name",
  enabled = function()
    return vim.fn.executable("command") == 1
  end,
  cond = function()
    return vim.fn.has("nvim-0.9") == 1
  end,
}
```

## LSP 設定の推奨パターン

### サーバー設定
```lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
  },
}
```

### フォーマッター設定
```lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
    },
  },
}
```

## 避けるべきパターン

### ❌ 悪い例
```lua
-- 設定が複雑すぎる
config = function()
  -- 100行以上の設定
end

-- ハードコードされたパス
opts = {
  path = "/Users/username/specific/path"
}

-- エラーハンドリングなし
config = function()
  require("plugin").setup() -- エラーチェックなし
end
```

### ✅ 良い例
```lua
-- シンプルな設定
opts = {
  -- 必要最小限の設定
},

-- 動的パス
opts = {
  path = vim.fn.stdpath("data") .. "/plugin-data"
},

-- エラーハンドリング
config = function()
  local ok, plugin = pcall(require, "plugin")
  if ok then
    plugin.setup()
  end
end
```

## ドキュメント

### 必須コメント
- プラグインの目的と機能
- 重要な設定項目の説明
- カスタムキーマップの説明

### コメント例
```lua
-- ファイルエクスプローラー機能を提供
-- <leader>e でトグル、<leader>E でカレントファイルにフォーカス
return {
  "nvim-neo-tree/neo-tree.nvim",
  -- ... 設定
}
```