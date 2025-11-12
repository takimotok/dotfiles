local km = require("util.key_mapper")

return {
  "godlygeek/tabular",
  config = function()
    local function tabularize_prompt()
      local delim = vim.fn.input("Align by: ")
      if delim ~= "" then
        vim.cmd("Tabularize /" .. delim)
      end
    end

    km.nmap("\\t", tabularize_prompt, { desc = "Tabularize with prompt" })
    km.xmap("\\t", tabularize_prompt, { desc = "Tabularize with prompt" })

    -- e.g.) in a .md file
    -- WARN: Don't use this command due to be insearted a space everytime executing `:Tabularize /|`
    -- km.nmap("<C-;>", ":Tabularize /|<CR>", { desc = "format .md tables by pipe" })
  end,
}
