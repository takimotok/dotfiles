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
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          "${workspaceFolder}/lua",
          "~/.local/share/nvim/lazy/conform.nvim/lua",
          "~/.local/share/nvim/lazy/nvim-lint/lua",
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
      },
    },
  },
}
