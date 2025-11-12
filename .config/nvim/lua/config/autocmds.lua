-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
  clear = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight the yanked text when yanked",
})

-- [[ UI ]]
-- local dotfiles_ui = vim.api.nvim_create_augroup("dotfiles.ui", {
--   clear = true,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   group = dotfiles_ui,
--   pattern = "*",
--   callback = function()
--     -- toggle listchars in startup
--     vim.opt.list = not vim.opt.list:get()
--   end,
-- })

-- [[ Markdown ]]
local dotfiles_markdown = vim.api.nvim_create_augroup("dotfiles.markdown", {
  clear = true,
})
local md_filetypes = require("util").md_filetypes

-- format on save
-- @see: lua/plugins/formatting/conform.lua
vim.api.nvim_create_autocmd("BufWritePre", {
  group = dotfiles_markdown,
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if vim.tbl_contains(md_filetypes, ft) then
      pcall(vim.cmd, "TableModeRealign")
    end
  end,
})

-- [[ LSP ]]
local dotfiles_lsp = vim.api.nvim_create_augroup("dotfiles.lsp", {
  clear = true,
})
local lsp_keymaps = require("config.keymaps")
vim.api.nvim_create_autocmd("LspAttach", {
  group = dotfiles_lsp,
  desc = "LSP actions",
  callback = function(event)
    -- local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local bufnr = event.buf

    -- @see: https://neovim.io/doc/user/lsp.html#lsp-defaults
    lsp_keymaps.on_attach(bufnr)
  end,
})
