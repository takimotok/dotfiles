-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local km = require("util.key_mapper")

km.nmap("<F2>", 'i<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.imap("<F2>", '<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })
km.nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.imap("<F3>", '<C-R>=strftime("%Y-%m-%d")<CR>', { desc = "insert date" })
km.nmap("<F4>", 'i<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })
km.imap("<F4>", '<C-R>=strftime("%y%m%d")<CR>', { desc = "insert date" })

-- quit
km.nmap("<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
km.nmap(
  "<C-[><C-[>",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- better indenting
km.vmap("<", "<gv", { desc = "repeatedly decrease indentation" })
km.vmap(">", ">gv", { desc = "repeatedly decrease indentation" })

-- Toggle listchars visibility
km.nmap("<leader>ut", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "[t]oggle listchars visibility" })

-- [[ File Path ]]
km.nmap("<leader>p", ":let @+ = expand('%')<CR>", { desc = "Copy file path" })

-- [[ Diagnostic ]]
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
km.nmap("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
km.nmap("]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
km.nmap("[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- km.nmap("]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- km.nmap("[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- km.nmap("]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- km.nmap("[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- [[ LSP ]]
local M = {}

---@class KeysBase
---@field mode string @see: `:h map-modes`
---@field lhs string lhs
---@field rhs? string|fun() rhs
---@field opts? table<string, any> options for `vim.keymap.set()`. see: `:h vim.keymap.set`
-- - "noremap": disables |recursive_mapping|, like |:noremap|
-- - "desc": human-readable description.
-- - "callback": Lua function called in place of {rhs}.
-- - buffer (`integer|boolean`): Creates buffer-local mapping, `0` or `true` for current buffer.
-- - remap (`boolean`, default: `false`) :Make the mapping recursive. Inverse of {noremap}.
-- - nowait
-- - silent
-- - script
-- - expr
-- - unique

---@alias kgKeysLspSpec KeysBase[]|nil key spec for LSP. `kg`: Kengo

---@type kgKeysLspSpec[] key spec for LSP. `kg`: Kengo
M._keys = nil

---@return kgKeysLspSpec
local function _get()
  if M._keys then
    return M._keys
  end

  -- stylua: ignore
  M._keys =  {
    { lhs = "<leader>cl", rhs = function() Snacks.picker.lsp_config() end, opts = {desc = "Lsp Info"} },
    { lhs = "gd", rhs = vim.lsp.buf.definition, opts = {desc = "Goto Definition"}, has = "definition" },
    { lhs = "<C-]>", rhs = vim.lsp.buf.definition, opts = {desc = "Goto Definition"}, has = "definition" },
    { lhs = "gr", rhs = vim.lsp.buf.references, opts = {desc = "References", nowait = true } },
    { lhs = "gI", rhs = vim.lsp.buf.implementation, opts = {desc = "Goto Implementation"} },
    { lhs = "gy", rhs = vim.lsp.buf.type_definition, opts = {desc = "Goto T[y]pe Definition"} },
    { lhs = "gD", rhs = vim.lsp.buf.declaration, opts = {desc = "Goto Declaration"} },
    { lhs = "K", rhs = function() return vim.lsp.buf.hover() end, opts = {desc = "Hover"} },
    { lhs = "gK", rhs = function() return vim.lsp.buf.signature_help() end, opts = {desc = "Signature Help"}, has = "signatureHelp" },
    { lhs = "<c-k>", rhs = function() return vim.lsp.buf.signature_help() end, mode = "i", opts = {desc = "Signature Help"}, has = "signatureHelp" },
    { lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, opts = { desc = "Code Action"}, mode = { "n", "v" }, has = "codeAction" },
    { lhs = "<leader>cc", rhs = vim.lsp.codelens.run, opts = {desc = "Run Codelens"}, mode = { "n", "v" }, has = "codeLens" },
    { lhs = "<leader>cC", rhs = vim.lsp.codelens.refresh, opts = {desc = "Refresh & Display Codelens"}, mode = { "n" }, has = "codeLens" },
    { lhs = "<leader>cR", rhs = function() Snacks.rename.rename_file() end, opts = {desc = "Rename File"}, mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
    { lhs = "<leader>cr", rhs = vim.lsp.buf.rename, opts = {desc = "Rename"}, has = "rename" },
  }

  return M._keys
end

---@param bufnr number
---@param method string|string[] LS Client's "textDocument/{method}"
---@return boolean
function M.has(bufnr, method)
  -- when the method is a table
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(bufnr, m) then
        return true
      end
    end

    return false
  end

  -- when the method is not a table
  -- NOTE: `method:find("/")` is the syntax sugar for `string.find(method, "/")` in neovim.
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end

  return false
end

-- Set LS's keymaps
---@param bufnr number
---@return nil
function M.on_attach(bufnr)
  local keymaps = _get()
  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(bufnr, keys.has)

    if has then
      keys.has = nil
      keys.opts.silent = keys.opts.silent ~= false
      keys.opts.buffer = bufnr

      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, keys.opts)
    end
  end
end

return M
