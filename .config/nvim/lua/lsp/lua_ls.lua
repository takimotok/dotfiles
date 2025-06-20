return {
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      format = {
        enable = false, -- styluaを使用
      },
    },
  },
}
