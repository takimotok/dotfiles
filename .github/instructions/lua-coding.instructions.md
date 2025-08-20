---
description: "Lua プログラミング用のコーディングガイドライン"
applyTo: "**/*.lua"
---

# Lua コーディングガイドライン

## スタイル規約

### インデントとフォーマット
- インデントは2スペースを使用
- 行末の空白は削除
- ファイル末尾に改行を追加

### 変数と関数の命名
- 変数名、関数名: `snake_case`を使用
- 定数: `UPPER_SNAKE_CASE`を使用
- プライベート関数: アンダースコアで開始 `_private_function`

### 文字列とテーブル
- 文字列はダブルクオートを優先: `"文字列"`
- テーブルの最後の要素にもカンマを付ける
```lua
local config = {
  option1 = "value1",
  option2 = "value2", -- ← この末尾カンマ
}
```

## Neovim Lua API の使用方法

### vim.* API の使用
- 新しいAPI(`vim.*`)を古いAPI(`vim.fn.*`)より優先
- 例: `vim.keymap.set()` > `vim.api.nvim_set_keymap()`

### エラーハンドリング
```lua
local ok, result = pcall(function()
  -- 潜在的にエラーを起こす可能性のあるコード
end)

if not ok then
  vim.notify("エラーメッセージ: " .. result, vim.log.levels.ERROR)
  return
end
```

### モジュール構造
```lua
local M = {}

-- 設定やヘルパー関数

M.setup = function(opts)
  -- セットアップ処理
end

return M
```

## LazyVim 固有のパターン

### プラグイン設定
- `return` でテーブルを返す形式
- `opts` テーブルでオプション指定
- `keys`, `cmd`, `event` で遅延読み込み設定

### キーマップ定義
```lua
keys = {
  { "<leader>ft", function() require("plugin").toggle() end, desc = "プラグインの切り替え" },
}
```

## パフォーマンス考慮

### 遅延読み込み
- プラグインは適切なイベント(`VeryLazy`, `BufReadPre`等)で読み込み
- 重い処理は必要時まで遅延

### メモリ効率
- 不要なグローバル変数は避ける
- 大きなテーブルは必要時に生成

## デバッグ
- `vim.inspect()` でテーブル内容を確認
- `vim.notify()` でデバッグメッセージ表示
- `:checkhealth` でプラグインの状態確認