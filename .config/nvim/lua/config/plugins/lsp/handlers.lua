local keymaps = require("config.plugins.lsp.keymaps")

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
      require("phpactor").setup({})
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

    -- pyright
    -- ["pyright"] = function()
    --   lspconfig.pyright.setup({
    --     on_attach = on_attach,
    --     capabilities = capabilities,
    --   })
    -- end,
  }
end

return M
