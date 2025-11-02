local M = {
  -- astro
  "astro",
  -- awk
  "awk_ls",
  -- bash
  "bashls",
  -- js
  "biome", -- also available as liter and formatter
  "eslint",
  "ts_ls",
  "vuels",
  -- css
  "cssls",
  "stylelint_lsp",
  -- docker
  "dockerls",
  "jsonls",
  -- lua
  "lua_ls",
  -- markdown
  "marksman",
  -- php
  -- NOTE: need openssl@1.1
  -- e.g.) Error messages:
  -- 	❯ ~/.local/share/nvim/mason/bin/phpactor --version
  -- dyld[22984]: Library not loaded: /opt/homebrew/opt/openssl@1.1/lib/libssl.1.1.dylib
  --   Referenced from: <41811118-70AE-3F17-988A-B7EF97F16F0D> ~/.local/share/mise/installs/php/8.3.11/bin/php
  --   Reason: tried: '/opt/homebrew/opt/openssl@1.1/lib/libssl.1.1.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/opt/homebrew/opt/openssl@1.1/lib/libssl.1.1.dylib' (no such file), '/opt/homebrew/opt/openssl@1.1/lib/libssl.1.1.dylib' (no such file)
  -- zsh: abort      ~/.local/share/nvim/mason/bin/phpactor --version
  "phpactor",
  -- python
  "pyright",
  "ruff",
  -- rust
  "rust_analyzer",
  -- sql
  "sqls",
  -- tailwind
  "tailwindcss",
  -- toml
  "taplo",

  -- ai
  -- installed via `mise` globally
  -- "copilot-language-server",
}

return M
