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

-- [[for Markdown files]]

-- retain folding view
-- List of file types to avoid in the display save state
local excluded_filetypes = {
  "git",
  "gitcommit",
  "gitrebase",
  "term",
  "terminal",
  "help",
  "nofile",
  "quickfix",
}

local function is_excluded(ft)
  return vim.tbl_contains(excluded_filetypes, ft)
end

local function can_save_view()
  local is_markdown = vim.bo.filetype == "markdown"

  local not_excluded = not is_excluded(vim.bo.filetype)

  local is_normal_buffer = vim.bo.buftype == ""

  return is_markdown and not_excluded and is_normal_buffer
end

-- define a directory to save view
vim.opt.viewdir = vim.fn.stdpath("data") .. "/view"

-- define which info is savaed
-- e.g.) "folds,cursor,curdir"
vim.opt.viewoptions = "folds"

-- automatically save when the file is closed
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.md" },
  callback = function()
    if can_save_view() then
      vim.cmd("silent! mkview")
    end
  end,
})

-- automatically load when the file is opened
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.md" },
  callback = function()
    if can_save_view() then
      vim.cmd("silent! loadview")
    end
  end,
})

-- format a table on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function()
    -- search for '||' pattern which likely indicates a table
    if vim.fn.search("\\|.*\\|", "nw") > 0 then
      vim.cmd("TableModeRealign")
    end
  end,
})

-- Markdown, Text, and Txt files
-- local md_files = vim.api.nvim_create_augroup("OpenMarkdownFiles", {
--   clear = true,
-- })
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   group = md_files,
--   pattern = { "*.md", "*.txt" },
--   command = "AerialOpen",
--   desc = "Open TOC by aerial",
-- })

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
