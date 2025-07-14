return {
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".git" },
  on_attach = function(client, _)
    -- Ruffはフォーマット機能を無効化し、診断のみを使用
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- ホバー機能も無効化（pyrightと重複するため）
    client.server_capabilities.hoverProvider = false
  end,
}