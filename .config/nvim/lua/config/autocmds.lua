-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- format .md tables on save
local md_filetypes = { "*.md", "*.mdx", "*.mdc", "*.codecompanion" }
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = md_filetypes,
  callback = function()
    -- search for '||' pattern which likely indicates a table
    if vim.fn.search("\\|.*\\|", "nw") > 0 then
      vim.cmd("TableModeRealign")
    end
  end,
})

