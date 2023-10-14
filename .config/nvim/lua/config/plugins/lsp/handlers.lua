local keymaps = require("config.plugins.lsp.keymaps")
local ltex_config = require("config.plugins.lsp.ltex")

ltex_config.init()

local M = {}

---@param client "client"
---@param bufnr number
local function on_attach(client, bufnr)
  keymaps.setup(bufnr)
end

---@param lspconfig SettingsPlugin
---@param capabilities  ("cmp_nvim_lsp").default_capabilities()
function M.setup(lspconfig, capabilities)
  return {
    -- default handler
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- bashls
    ["bashls"] = function()
      lspconfig.bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "zsh", "sh" },
      })
    end,

    -- phpactor
    ["phpactor"] = function()
      lspconfig.phpactor.setup({
        capabilities = capabilities,
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
        },
      })
    end,

    -- ltex
    ["ltex"] = function()
      lspconfig.ltex.setup({
        on_attach = ltex_config.on_attach,
        capabilities = capabilities,
        use_spellfile = false,
        filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
        settings = {
          ltex = {
            enabled = { "latex", "tex", "bib", "markdown" },
            language = "en-US",
            diagnosticSeverity = "information",
            sentenceCacheSize = 2000,
            additionalRules = {
              enablePickyRules = true,
              motherTongue = "ja-JP",
            },
            dictionary = ltex_config.read_dictionaries(),
          },
        },
      })
    end,

    -- lua_ls
    ["lua_ls"] = function()
      -- cf.) https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            -- runtime = {
            --   version = "LuaJIT",
            -- },
            diagnostics = {
              globals = {
                "vim",
              },
            },
            workspace = {
              -- commented out for saving memory
              -- library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,

    -- rust
    ["rust_analyzer"] = function()
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            -- checkOnSave = {
            --   command = "clippy",
            -- },
            diagnostics = {
              enable = false,
            },
          },
        },
      })
    end,

    -- volar (vue.js language server)
    ["volar"] = function()
      lspconfig.volar.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })
    end,

    -- zk
    -- ["zk"] = function()
    --   lspconfig.zk.setup({
    --     on_attach = on_attach,
    --     -- settings = {},
    --   })
    -- end,

    -- pyright
    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- ruff_lsp
    ["ruff_lsp"] = function()
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
end

return M
