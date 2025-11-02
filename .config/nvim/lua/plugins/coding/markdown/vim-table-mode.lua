local km = require("util.key_mapper")
local md_filetypes = require("util").md_filetypes

return {
  "dhruvasagar/vim-table-mode",
  lazy = true,
  ft = md_filetypes,
  config = function()
    km.nmap("<C-;>", ":TableModeRealign<CR>", { desc = "format md tables" })
  end,
}
