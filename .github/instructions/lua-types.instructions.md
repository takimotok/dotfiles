---
description: "Lua 型定義ファイル用のガイドライン"
applyTo: "**/types/*.lua"
---

# Lua 型定義ガイドライン

## 基本的な型注釈

### EmmyLua アノテーション
```lua
---@class Config
---@field name string プラグイン名
---@field enabled boolean 有効フラグ
---@field options table オプション設定

---@param config Config 設定オブジェクト
---@return boolean success 成功フラグ
local function setup(config)
  -- 実装
end
```

### 複雑な型定義
```lua
---@alias KeymapMode "n"|"i"|"v"|"x"|"s"|"o"|"c"|"t"

---@class KeymapSpec
---@field [1] string キー
---@field [2] string|function コマンドまたは関数
---@field desc string 説明
---@field mode KeymapMode|KeymapMode[] モード
---@field buffer boolean|number バッファローカル
---@field silent boolean サイレント実行

---@type KeymapSpec[]
local keymaps = {
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "ファイル検索" },
}
```

## プラグイン設定の型定義

### LazyVim プラグイン仕様
```lua
---@class LazyPluginSpec
---@field [1] string プラグインURL
---@field dependencies string|LazyPluginSpec[] 依存関係
---@field event string|string[] 読み込みイベント
---@field cmd string|string[] コマンド
---@field ft string|string[] ファイルタイプ
---@field keys KeymapSpec[] キーマップ
---@field opts table オプション
---@field config function 設定関数
---@field enabled boolean|function 有効フラグ
---@field cond boolean|function 条件
```

### LSP設定の型定義
```lua
---@class LspServerConfig
---@field cmd string[] 起動コマンド
---@field filetypes string[] 対象ファイルタイプ
---@field root_dir function ルートディレクトリ検出
---@field settings table サーバー固有設定
---@field on_attach function アタッチ時コールバック
---@field capabilities table 機能設定

---@class LspConfig
---@field servers table<string, LspServerConfig> サーバー設定
---@field setup table<string, function> セットアップ関数
```

## Neovim API の型定義

### オプション設定
```lua
---@class VimOption
---@field number boolean 行番号表示
---@field relativenumber boolean 相対行番号
---@field tabstop number タブ幅
---@field shiftwidth number インデント幅
---@field expandtab boolean スペース展開
---@field wrap boolean 行の折り返し
---@field signcolumn string サインカラム設定
```

### オートコマンド
```lua
---@class AutocmdSpec
---@field group string|number グループ
---@field pattern string|string[] パターン
---@field callback function コールバック関数
---@field command string コマンド
---@field once boolean 一度だけ実行
---@field nested boolean ネストした実行
---@field desc string 説明

---@param event string|string[] イベント
---@param opts AutocmdSpec オプション
local function create_autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end
```

## カスタム型の定義

### 設定モジュールの型
```lua
---@class ConfigModule
---@field options VimOption Neovimオプション
---@field keymaps KeymapSpec[] キーマップ定義
---@field autocmds AutocmdSpec[] オートコマンド定義
---@field plugins LazyPluginSpec[] プラグイン設定

---@type ConfigModule
local M = {}
```

### ユーティリティ関数の型
```lua
---@class Utils
local Utils = {}

---ファイルが存在するかチェック
---@param path string ファイルパス
---@return boolean exists 存在フラグ
function Utils.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

---テーブルをマージ
---@param t1 table ベーステーブル
---@param t2 table マージするテーブル
---@return table merged マージ済みテーブル
function Utils.merge(t1, t2)
  return vim.tbl_deep_extend("force", t1, t2)
end
```

## 実用的な型定義例

### テーマ設定
```lua
---@class ColorScheme
---@field name string テーマ名
---@field background "dark"|"light" 背景色
---@field transparent boolean 透明背景
---@field colors table<string, string> カスタムカラー

---@class ThemeConfig
---@field colorscheme ColorScheme カラースキーム
---@field lualine table ステータスライン設定
---@field notify table 通知設定
```

### フォーマッター設定
```lua
---@class FormatterConfig
---@field command string フォーマッターコマンド
---@field args string[] 引数
---@field stdin boolean 標準入力使用
---@field cwd string 作業ディレクトリ
---@field env table<string, string> 環境変数

---@class ConformConfig
---@field formatters table<string, FormatterConfig> フォーマッター定義
---@field formatters_by_ft table<string, string[]> ファイルタイプ別設定
---@field format_on_save boolean|table 保存時フォーマット
```

## 型チェックの活用

### 関数の入力検証
```lua
---@param config table 設定テーブル
---@return boolean valid 有効性
local function validate_config(config)
  vim.validate({
    name = { config.name, "string" },
    enabled = { config.enabled, "boolean", true },
    options = { config.options, "table", true },
  })
  return true
end
```

### 型ガード
```lua
---@param value any チェック対象
---@return boolean is_string 文字列フラグ
local function is_string(value)
  return type(value) == "string"
end

---@param value any チェック対象
---@return boolean is_table テーブルフラグ
local function is_table(value)
  return type(value) == "table"
end
```

## ドキュメント生成

### モジュールの説明
```lua
---Neovim設定ユーティリティモジュール
---
---このモジュールはNeovim設定の共通処理を提供します。
---プラグイン設定、キーマップ、オートコマンドの管理機能を含みます。
---
---@module "utils"

local M = {}
```

### 使用例の記載
```lua
---キーマップを設定する
---
---使用例:
---```lua
---local keymap = require("utils.keymap")
---keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {
---  desc = "ファイル検索"
---})
---```
---
---@param mode string|string[] モード
---@param key string キー
---@param command string|function コマンド
---@param opts table オプション
function M.set(mode, key, command, opts)
  -- 実装
end
```