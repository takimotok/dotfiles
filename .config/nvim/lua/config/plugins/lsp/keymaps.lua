local km = require("core.key_mapper")

local M = {}

function M.setup(bufnr)
  -- km.nmap('<C-k>', '<cmd>vim.lsp.buf.signature_help()<CR>')
  -- km.nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  -- km.nmap('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>'
  local opts = { noremap = true, silent = true, buffer = bufnr }

  km.nmap("<leader>ls", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  km.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  km.nmap("gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  km.nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  km.nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  km.nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  km.nmap("gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  km.nmap("ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  km.nmap("ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  km.nmap("g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  km.nmap("g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

  -- open diagnostics w/ telescope
  km.nmap("<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
  -- km.nmap('<leader>dws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[D]ynamic [W]orkspace [S]ymbols')


  -- modify workspaces
  km.nmap("<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  km.nmap("<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  km.nmap("<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

return M
