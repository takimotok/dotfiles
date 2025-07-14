return {
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  settings = {
    json = {
      format = { enable = false }, -- フォーマットは無効化
      validate = { enable = true },
      schemas = (function()
        local ok, schemastore = pcall(require, "schemastore")
        if ok then
          return schemastore.json.schemas()
        else
          return {}
        end
      end)(),
    },
  },
}