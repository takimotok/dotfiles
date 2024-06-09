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

    -- intelephense
    -- @see: https://github.com/bmewburn/intelephense-docs/blob/master/gettingStarted.md
    -- ["intelephense"] = function()
    --   lspconfig.intelephense.setup({
    --     name = "intelephense",
    --     commands = {
    --       IntelephenseIndex = {
    --         function()
    --           vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
    --         end,
    --       },
    --     },
    --     files = {
    --       exclude = {
    --         "**/.git/**",
    --         "**/.DS_Store/**",
    --         "**/node_modules/**",
    --         "**/bower_components/**",
    --         "**/vendor/**/{Tests,tests}/**",
    --         "**/.history/**",
    --         "**/vendor/**/vendor/**",
    --       };
    --     },
    --     environment = {
    --       phpVersion = "7.4.33",
    --     },
    --     root_dir =  function()
    --       return vim.fs.dirname(vim.fs.find({'composer.json'}, { upward = true })[1])
    --     end,
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --   })
    -- end,

    -- phpactor
    ["phpactor"] = function()
      lspconfig.phpactor.setup({
        name = "phpactor",
        capabilities = capabilities,
        init_options = {
          ["language_server_php_cs_fixer.enabled"] = false,
          ["language_server_phpstan.enabled"] = false,
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
            markdown = {
              nodes = {
                AutoLink = "ignore",
                Code = "dummy",
                CodeBlock = "ignore",
                FencedCodeBlock = "ignore",
                Link = "ignore",
              },
            },
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

    -- stylelint_lsp
    -- cf.) https://github.com/bmatcuk/stylelint-lsp/issues/30#issuecomment-1047317921
    ["stylelint_lsp"] = function()
      lspconfig.stylelint_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "css",
          "less",
          "scss",
          "sugarss",
          "vue",
          "wxss",
        },
        settings = {
          stylelintplus = {
            cssInJs = false,
          },
        },
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
        root_dir = lspconfig.util.root_pattern(".venv"),
        cmd = { "zsh", "-c", "source .venv/bin/activate" },
        -- cmd = { "zsh", "-c", "source .venv/bin/activate && .venv/bin/pyright-langserver --stdio" },
        -- @TODO: 2024-06-05 もし warning がウザかったら comment in する
        -- settings = {
        --   pyright = {
        --     -- Using Ruff's import organizer
        --     disableOrganizeImports = true,
        --   },
        --   python = {
        --     analysis = {
        --       -- Ignore all files for analysis to exclusively use Ruff for linting
        --       ignore = { "*" },
        --     },
        --   },
        -- },
      })
    end,

    -- ruff_lsp
    -- [astral-sh/ruff-lsp: A Language Server Protocol implementation for Ruff.](https://github.com/astral-sh/ruff-lsp)
    ["ruff_lsp"] = function()
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
end

return M
