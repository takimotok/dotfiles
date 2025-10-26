return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" },
      },
    },
  },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    -- '.git',
  },
}
