local km = require("util.key_mapper")

return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function(_, opts)
    local todo_comments = require("todo-comments")
    todo_comments.setup(opts)

    -- keymaps
    km.nmap("]t", todo_comments.jump_next, { desc = "Next todo comment" })
    km.nmap("[t", todo_comments.jump_prev, { desc = "Previous todo comment" })

    -- w/ Snacks picker
    km.nmap("<leader>st", function()
      Snacks.picker.todo_comments()
    end, { desc = "Todo" })

    -- commands
    -- :TodoTelescope
    -- :TodoTrouble
    -- :TodoLocList
    -- :TodoQuickFix
    -- :TodoFzfLua

    -- keywords: don't forget to append `:` just after those below. Case-sensitive.
    -- 	- FIX:
    -- 	- TODO:
    -- 	- HACK:
    -- 	- WARN:
    -- 	- PERF:
    -- 	- NOTE:
    -- 	- TEST:
  end,
}
