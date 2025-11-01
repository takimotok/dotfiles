local km = require("util.key_mapper")

return {
  "godlygeek/tabular",
  ft = { "csv" },
  config = function()
    -- .csv keymaps
    km.nmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })
    km.xmap("t,", ":Tabularize /,<CR>", { desc = "format csv by comma" })

    -- e.g.) in a .md file
    -- km.nmap("<C-;>", ":Tabularize /|<CR>", { desc = "format csv by comma" })
  end,
}
