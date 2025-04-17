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

-- [[for all files]]
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_echo({ { "Running conform.nvim format", "WarningMsg" } }, true, {})
--     require("conform").format({
--       lsp_fallback = "never", -- LSP フォーマットを無効化
--       async = false, -- 同期的に実行
--       timeout_ms = 500, -- タイムアウトを設定
--     })
--   end,
--   desc = "Format file on save using conform.nvim",
-- })

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
  pattern = { "*.md", "*.mdx" },
  callback = function()
    -- search for '||' pattern which likely indicates a table
    if vim.fn.search("\\|.*\\|", "nw") > 0 then
      vim.cmd("TableModeRealign")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    -- vim.opt_local.formatoptions:remove({ "t" })
    -- vim.opt_local.formatoptions:append({ "p" })
  end,
})

-- [[ for LSP ]]
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)

--     -- 全ての LSP サーバーの formatting 機能を無効化
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false

--     -- サーバーがハイライト機能をサポートしている場合のみ自動ハイライトを設定
--     if client and client.server_capabilities.documentHighlightProvider then
--       local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. args.buf, { clear = true })
--       vim.api.nvim_create_autocmd("CursorHold", {
--         group = group,
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.document_highlight()
--         end,
--       })
--       vim.api.nvim_create_autocmd("CursorMoved", {
--         group = group,
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.clear_references()
--         end,
--       })
--     end
--   end,
-- })

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

