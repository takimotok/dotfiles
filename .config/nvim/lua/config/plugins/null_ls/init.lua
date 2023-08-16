local M = {}

M.ensure_installed = {
  "editorconfig_checker",
  "jq",
  "luacheck",
  "prettier",
  "ruff",
  "shellcheck",
  "shfmt",
  "stylua",
  "black",
  -- "isort",
}

M.diagnostic_config = {
  virtual_text = false,
}

M.diagnostics_format = "[#{c}] (#{s}) #{m}"

M.sources = {}

---@param null_ls table
local function set_sources(null_ls)
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  M.sources = {
    -- shell
    formatting.shfmt.with({
      filetypes = { "zsh", "sh" },
    }),
    diagnostics.shellcheck.with({
      filetypes = { "zsh", "sh" },
    }),
    code_actions.shellcheck.with({
      filetypes = { "zsh", "sh" },
    }),

    -- lua
    formatting.stylua,
    diagnostics.luacheck.with({
      extra_args = { "--globals", "vim" },
    }),

    -- python
    formatting.ruff,
    formatting.black,
    diagnostics.ruff,
    -- code_actions.ruff,

    -- markdown
    formatting.prettier,

    -- editorconfig
    diagnostics.editorconfig_checker,
  }
end

---@param null_ls table
function M.setup(null_ls)
  set_sources(null_ls)
end

--- format on save
---@param client "lsp client"
---@param bufnr number
function M.on_attach(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {
    clear = true,
  })

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

return M
