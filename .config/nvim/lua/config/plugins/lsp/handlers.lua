local M = {}

---@param plugin_names string[]
---@return string[]
local function get_plugin_paths(plugin_names)
  local plugins = require("lazy.core.config").plugins
  local paths = {}
  for _, name in ipairs(plugin_names) do
    if plugins[name] then
      table.insert(paths, plugins[name].dir .. "/lua")
    else
      vim.notify("Invalid plugin name: " .. name)
    end
  end
  return paths
end

---@param plugins string[]
---@return string[]
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  table.insert(paths, vim.fn.stdpath("config") .. "/lua")
  table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

---@return table
function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  return {
    -- default handler
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,

    -- bashls
    ["bashls"] = function()
      lspconfig.bashls.setup({
        capabilities = capabilities,
        filetypes = { "zsh", "sh" },
      })
    end,

    -- yamlls
    -- ["yamlls"] = function()
    --   lspconfig.yamlls.setup({
    --     capabilities = capabilities,
    --     settings = {
    --       yaml = {
    --         schemas = {
    --           -- プロジェクトごとのスキーマを指定可能
    --           ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
    --         },
    --       },
    --     },
    --   })
    -- end,

    -- jsonls
    -- ["jsonls"] = function()
    --   lspconfig.jsonls.setup({
    --     capabilities = capabilities,
    --     -- Add any specific settings you need
    --   })
    -- end,

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
    --   })
    -- end,

    -- phpactor
    ["phpactor"] = function()
      lspconfig.phpactor.setup({
        name = "phpactor",
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        capabilities = capabilities,
        init_options = {
          ["language_server_php_cs_fixer.enabled"] = false,
          ["language_server_phpstan.enabled"] = false,
        },
        cmd = { "phpactor", "language-server" },
        root_dir = function(fname)
          -- 次の順で project root を探す
          return lspconfig.util.root_pattern(".phpactor.json", "composer.json", ".git")(fname)
        end,
      })
    end,

    -- ltex
    -- ["ltex"] = function()
    --   local ltex_config = require("config.plugins.lsp.ltex")

    --   ltex_config.init()

    --   lspconfig.ltex.setup({
    --     on_attach = ltex_config.on_attach,
    --     capabilities = capabilities,
    --     use_spellfile = false,
    --     filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
    --     settings = {
    --       ltex = {
    --         enabled = { "latex", "tex", "bib", "markdown" },
    --         language = "en-US",
    --         diagnosticSeverity = "information",
    --         sentenceCacheSize = 2000,
    --         additionalRules = {
    --           enablePickyRules = true,
    --           motherTongue = "ja-JP",
    --         },
    --         dictionary = ltex_config.read_dictionaries(),
    --         markdown = {
    --           nodes = {
    --             AutoLink = "ignore",
    --             Code = "dummy",
    --             CodeBlock = "ignore",
    --             FencedCodeBlock = "ignore",
    --             Link = "ignore",
    --           },
    --         },
    --       },
    --     },
    --   })
    -- end,

    -- lua_ls
    ["lua_ls"] = function()
      -- cf.) https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            hint = { enable = true },
            runtime = {
              version = "LuaJIT",
              pathStrit = true,
              path = {
                "?.lua",
                "?/init.lua",
              },
            },
            workspace = {
              -- cf.) https://zenn.dev/uga_rosa/articles/afe384341fc2e1
              library = library({ "lazy.nvim" }),
              checkThirdParty = "Disable",
            },
            diagnostics = {
              globals = {
                "vim",
              },
            },
          },
        },
      })
    end,

    -- rust
    ["rust_analyzer"] = function()
      lspconfig.rust_analyzer.setup({
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
        capabilities = capabilities,
        filetypes = { "vue" },
      })
    end,

    -- js, ts
    ["biome"] = function()
      lspconfig.biome.setup({
        capabilities = capabilities,
        cmd = { "biome", "lsp-proxy" },
        on_new_config = function(new_config)
          local yarn = lspconfig.util.root_pattern(".yarn", "yarn.lock", ".yarnrc.yaml")(vim.api.nvim_buf_get_name(0))
          local cmd = { "npx", "biome", "lsp-proxy" }
          if yarn then
            cmd = { "yarn", "biome", "lsp-proxy" }
          end
          new_config.cmd = cmd
        end,
      })
    end,

    -- stylelint_lsp
    -- cf.) https://github.com/bmatcuk/stylelint-lsp/issues/30#issuecomment-1047317921
    ["stylelint_lsp"] = function()
      lspconfig.stylelint_lsp.setup({
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

    -- pyright
    ["pyright"] = function()
      lspconfig.pyright.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".venv"),
        cmd = { "zsh", "-c", "source .venv/bin/activate" },
      })
    end,

    -- ruff
    -- @TODO: suppress double warnings
    -- e.g.)
    --    [Ruff]: `sys` imported but unused [F401]
    --    [Ruff]: `sys` imported but unused [F401]
    ["ruff"] = function()
      lspconfig.ruff.setup({
        capabilities = capabilities,
      })
    end,

    ["zk"] = function()
      lspconfig.zk.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- フォーマット機能を無効化
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- documentHighlight機能を無効化
          client.server_capabilities.documentHighlightProvider = false
        end,
      })
    end,
  }
end

return M

