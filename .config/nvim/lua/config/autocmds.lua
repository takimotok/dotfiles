-- [[ Basic Autocmds ]]

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

-- mason-tool-installer
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsStartingInstall",
  callback = function()
    vim.schedule(function()
      print("mason-tool-installer is starting")
    end)
  end,
})

-- Markdown, Text, and Txt files
local md_files = vim.api.nvim_create_augroup("OpenMarkdownFiles", {
  clear = true,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = md_files,
  pattern = { "*.md", "*.txt" },
  command = "AerialOpen",
  desc = "Open TOC by aerial",
})

-- enable :spell command on .md and .txt
-- local spell_texts = vim.api.nvim_create_augroup("SpellTexts", {
--   clear = true,
-- })
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = spell_texts,
--   pattern = { "*.md", "*.txt" },
--   command = [[
--     set spelllang="en_us,cjk"
--     set complete+=kspell
--     set spell!
--   ]],
--   desc = "Check spells especially in .md and .txt",
-- })

-- auto source init.lua after making changes
-- local source_myvimrc = vim.api.nvim_create_augroup("SourceMyVimrc", {
--   clear = true,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = source_myvimrc,
--   pattern = { "$MYVIMRC" },
--   command = [[
--     source %
--   ]],
--   desc = "Source $MYVIMRC when make changes",
-- })
