local M = {}

M.ensure_installed = {
  "astro",
  "awk_ls",
  "biome",
  "bashls",
  "eslint",
  "jsonls",
  -- "ltex",
  "lua_ls",
  -- "marksman",
  -- "phpactor@2022.11.12", -- for php7.x
  "phpactor", -- for php7.x
  -- "intelephense",
  "pyright",
  "ruff",
  "rust_analyzer",
  -- "sqlls",
  "sqls",
  "stylelint_lsp",
  -- "tailwindcss",
  "ts_ls",
  "volar",
  -- "yamlls",
}

local function setup_diagnostic()
  local errorSign = "✘"
  local warnSign = "⚠️"
  local hintSign = "💡"
  local infoSign = "󰙎"

  local config = {
    virtual_text = false,
    update_in_insert = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = errorSign,
        [vim.diagnostic.severity.WARN] = warnSign,
        [vim.diagnostic.severity.HINT] = hintSign,
        [vim.diagnostic.severity.INFO] = infoSign,
      },
    },
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      -- source = "always",
      header = "",
      prefix = "",
      format = function(diagnostic)
        return string.format("[%s]: %s", diagnostic.source, diagnostic.message)
      end,
    },
  }
  vim.diagnostic.config(config)
end

local function setup_hover()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

local function setup_signature_help()
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function setup_keymaps()
  local lsp_keymaps = require("config.plugins.lsp.keymaps")

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end

      lsp_keymaps.setup(args.buf)
    end,
  })
end

function M.setup()
  setup_diagnostic()
  setup_hover()
  setup_signature_help()
  setup_keymaps()
end

return M

