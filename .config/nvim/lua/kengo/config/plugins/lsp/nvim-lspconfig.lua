local M = {}

M.load_server_config = function(server_name)
  local ok, config = pcall(require, "lsp." .. server_name)
  if not ok then
    vim.notify("🤔 Failed to load LSP config for " .. server_name, vim.log.levels.WARN)
    return {}
  end

  return config
end

--- LazyVim が期待する構造を返す
---@return table
M.opts = function()
  -- カスタム診断設定を読み込み
  local diagnostics_config = require("kengo.config.plugins.lsp.diagnostics")
  local custom_diagnostics = diagnostics_config.get_diagnostic_config()

  return {
    -- options for vim.diagnostic.config()
    diagnostics = custom_diagnostics,
    -- inlay hints設定
    inlay_hints = {
      enabled = true,
      exclude = { "vue" }, -- LazyVimのデフォルト除外設定
    },
    -- codelens設定
    codelens = {
      enabled = false, -- LazyVimのデフォルト設定
    },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- サーバー設定
    servers = {
      -- Lua
      lua_ls = M.load_server_config("lua_ls"),
      -- PHP
      phpactor = M.load_server_config("phpactor"),
      -- TypeScript/JavaScript - 重複するサーバーを無効化
      ts_ls = {
        enabled = false,
      },
      tsserver = {
        enabled = false,
      },
      -- ESLint LSPを無効化（nvim-lintを使用するため）
      eslint = {
        enabled = false,
      },
      -- JavaScript/TypeScript
      vtsls = M.load_server_config("vtsls"),
      -- Astro
      astro = M.load_server_config("astro"),
      -- Tailwind
      tailwindcss = M.load_server_config("tailwindcss"),
      -- Python
      pyright = M.load_server_config("pyright"),
      ruff = M.load_server_config("ruff"),
      -- Rust
      rust_analyzer = M.load_server_config("rust_analyzer"),
      -- SQL
      sqls = M.load_server_config("sqls"),
      -- TOML
      taplo = M.load_server_config("taplo"),
      -- JSON
      jsonls = M.load_server_config("jsonls"),
      -- Docker
      dockerls = M.load_server_config("dockerls"),
      docker_compose_language_service = M.load_server_config("docker_compose_language_service"),
    },
    -- セットアップ関数
    setup = {
      -- 各サーバーに対して、フォーマット機能を確実に無効化
      ["*"] = function(_, opts)
        if opts.on_attach then
          local original_on_attach = opts.on_attach
          opts.on_attach = function(client, bufnr)
            -- フォーマット機能を無効化
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            original_on_attach(client, bufnr)
          end
        else
          opts.on_attach = function(client, _)
            -- フォーマット機能を無効化
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end
        return false -- デフォルトのlspconfig setupを続行
      end,
    },
  }
end

return M
