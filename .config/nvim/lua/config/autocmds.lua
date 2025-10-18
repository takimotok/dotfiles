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

-- [[ Markdown ]]
local md_filetypes = require("util").md_filetypes

-- Enable treesitter for markdown files.
-- ∵ According to `:checkhealth render-markdown`:
--  ```
--  render-markdown.nvim [tree-sitter markdown] ~
--  ❌ ERROR highlighter: not enabled
--  - ADVICE:
--    - call vim.treesitter.start on markdown buffers
--  ```
-- It causes not to caonceal links.
vim.api.nvim_create_autocmd("FileType", {
  pattern = md_filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = md_filetypes,
  callback = function()
    -- search for '||' pattern which likely indicates a table
    if vim.fn.search("\\|.*\\|", "nw") > 0 then
      vim.cmd("TableModeRealign")
    end
  end,
})
