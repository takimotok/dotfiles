local km = require("util.key_mapper")
local md_filetypes = require("util").md_filetypes

return {
  "zk-org/zk-nvim",
  lazy = true,
  ft = md_filetypes,
  config = function()
    require("zk").setup({
      picker = "select",
    })

    -- @TODO: couldn't show desc in which-key window w/ `km` functions
    -- keymaps
    -- Open notes associated with the selected tags.
    km.nmap("<leader>zt", "<Cmd>ZkTags<CR>", { desc = "With [Z]k-nvim, search notes by [T]ags" })

    -- keymaps
    -- Search for the notes matching a given query.
    km.nmap(
      "<leader>zf",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      { desc = "With [Z]k-nvim, [F]ind notes by given queries" }
    )
  end,
}
