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
local dotfiles_ui = vim.api.nvim_create_augroup("dotfiles.ui", {
  clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
  group = dotfiles_ui,
  pattern = "*",
  callback = function()
    -- toggle listchars in startup
    vim.opt.list = not vim.opt.list:get()
  end,
})

-- [[ Markdown ]]
local dotfiles_markdown = vim.api.nvim_create_augroup("dotfiles.markdown", {
  clear = true,
})
local md_filetypes = require("util").md_filetypes

-- Enable treesitter for markdown files.
--
-- ∵ According to `:checkhealth render-markdown`:
--  ```
--  render-markdown.nvim [tree-sitter markdown] ~
--  ❌ ERROR highlighter: not enabled
--  - ADVICE:
--    - call vim.treesitter.start on markdown buffers
--  ```
-- It causes not to caonceal links.
vim.api.nvim_create_autocmd("FileType", {
  group = dotfiles_markdown,
  pattern = md_filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = dotfiles_markdown,
  pattern = md_filetypes,
  callback = function()
    -- search for '||' pattern which likely indicates a table
    if vim.fn.search("\\|.*\\|", "nw") > 0 then
      vim.cmd("TableModeRealign")
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
