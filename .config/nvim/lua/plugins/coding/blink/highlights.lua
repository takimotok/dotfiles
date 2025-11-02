-- Highlight settings for blink.cmp

local M = {}

function M.setup()
  -- スニペット専用のハイライトグループを定義
  vim.api.nvim_set_hl(0, "BlinkCmpLabelSnippet", {
    fg = "#C792EA", -- 紫色でスニペットを強調
    bold = true,
  })

  vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", {
    fg = "#C792EA", -- アイコンも同じ色
    bold = true,
  })

  -- その他のkindアイコンの色も設定
  vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#82AAFF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#82AAFF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#EEFFFF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#FFCB6B" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#C3E88D" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#F78C6C" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#89DDFF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", { fg = "#6CC644" })
end

return M
