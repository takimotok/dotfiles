---@meta

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local d = ls.dynamic_node
-- local sn = ls.snippet_node

---LuaCATSアノテーション用のスニペット集
local luacats_snippets = {
  -- クラス定義スニペット
  s("class", {
    t("---@class "),
    i(1, "ClassName"),
    t(" "),
    i(2, "クラスの説明"),
    t({ "", "---@field " }),
    i(3, "fieldName"),
    t(" "),
    i(4, "string"),
    t(" "),
    i(5, "フィールドの説明"),
    t({ "", "local " }),
    i(6, "ClassName"),
    t(" = {}"),
    t({ "", "" }),
    i(0),
  }),

  -- 関数アノテーションスニペット
  s("func", {
    t("---"),
    i(1, "関数の説明"),
    t({ "", "---@param " }),
    i(2, "param"),
    t(" "),
    i(3, "string"),
    t(" "),
    i(4, "パラメータの説明"),
    t({ "", "---@return " }),
    i(5, "string"),
    t(" "),
    i(6, "戻り値の説明"),
    t({ "", "function " }),
    i(7, "functionName"),
    t("("),
    i(8, "param"),
    t(")"),
    t({ "", "  " }),
    i(0),
    t({ "", "end" }),
  }),

  -- 型エイリアススニペット
  s("alias", {
    t("---@alias "),
    i(1, "TypeName"),
    t(" "),
    i(2, "string"),
    t(" "),
    i(3, "型の説明"),
  }),

  -- パラメータアノテーション
  s("param", {
    t("---@param "),
    i(1, "name"),
    t(" "),
    i(2, "string"),
    t(" "),
    i(3, "説明"),
  }),

  -- 戻り値アノテーション
  s("return", {
    t("---@return "),
    i(1, "string"),
    t(" "),
    i(2, "name"),
    t(" "),
    i(3, "説明"),
  }),

  -- 型アノテーション
  s("type", {
    t("---@type "),
    i(1, "string"),
  }),

  -- フィールドアノテーション
  s("field", {
    t("---@field "),
    i(1, "name"),
    t(" "),
    i(2, "string"),
    t(" "),
    i(3, "説明"),
  }),

  -- モジュール定義
  s("module", {
    t("---@meta"),
    t({ "", "" }),
    t({ "", "---@class " }),
    i(1, "ModuleName"),
    t(" "),
    i(2, "モジュールの説明"),
    t({ "", "---@field " }),
    i(3, "property"),
    t(" "),
    i(4, "string"),
    t(" "),
    i(5, "プロパティの説明"),
    t({ "", "" }),
    t({ "", "local M = {}" }),
    t({ "", "" }),
    i(0),
    t({ "", "" }),
    t({ "", "---@return " }),
    i(6, "ModuleName"),
    t({ "", "return M" }),
  }),

  -- 設定テーブル
  s("config", {
    t("---@class "),
    i(1, "Config"),
    t(" "),
    i(2, "設定の説明"),
    t({ "", "---@field " }),
    i(3, "option"),
    t(" "),
    i(4, "string"),
    t(" "),
    i(5, "オプションの説明"),
    t({ "", "---@field " }),
    i(6, "enabled"),
    t("? boolean "),
    i(7, "有効/無効（オプション）"),
  }),

  -- 複数の戻り値
  s("returns", {
    t("---@return "),
    i(1, "boolean"),
    t(" "),
    i(2, "success"),
    t(" "),
    i(3, "成功したかどうか"),
    t({ "", "---@return " }),
    i(4, "string|nil"),
    t(" "),
    i(5, "error"),
    t(" "),
    i(6, "エラーメッセージ"),
  }),

  -- 配列型
  s("array", {
    t("---@type "),
    i(1, "string"),
    t("[] "),
    i(2, "配列の説明"),
  }),

  -- 辞書型
  s("dict", {
    t("---@type table<"),
    i(1, "string"),
    t(", "),
    i(2, "any"),
    t("> "),
    i(3, "辞書の説明"),
  }),

  -- オプショナル型
  s("optional", {
    t("---@param "),
    i(1, "name"),
    t("? "),
    i(2, "string"),
    t(" "),
    i(3, "オプションパラメータの説明"),
  }),

  -- Union型
  s("union", {
    t("---@type "),
    i(1, "string"),
    t(" | "),
    i(2, "number"),
    t(" "),
    i(3, "Union型の説明"),
  }),
}

return luacats_snippets

