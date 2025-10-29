local km = require("util.key_mapper")

return {
  -- Syntax aware text-objects, select, move, swap, and peek support.
  -- In this file, Specifically use the move operation.
  -- @see: lua/plugins/coding/mini_ai.lua
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  opts = {
    move = {
      set_jumps = true, -- whether to set jumps in the jumplist
    },
  },

  -- stylua: ignore
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    local m = require("nvim-treesitter-textobjects.move")

    -- [[ goto next start ]]
    km.nmap("]f", function() m.goto_next_start("@function.outer", "textobjects") end)
    km.nmap("]c", function() m.goto_next_start("@class.outer", "textobjects") end)
    km.nmap("]a", function() m.goto_next_start("@parameter.inner", "textobjects") end)

    -- [[ goto next end ]]
    km.nmap("]F", function() m.goto_next_end("@function.outer", "textobjects") end)
    km.nmap("]C", function() m.goto_next_end("@class.outer", "textobjects") end)
    km.nmap("]A", function() m.goto_next_end("@parameter.inner", "textobjects") end)

    -- [[ goto previous start ]]
    km.nmap("[f", function() m.goto_previous_start("@function.outer", "textobjects") end)
    km.nmap("[c", function() m.goto_previous_start("@class.outer", "textobjects") end)
    km.nmap("[a", function() m.goto_previous_start("@parameter.inner", "textobjects") end)

    -- [[ goto previous end ]]
    km.nmap("[F", function() m.goto_previous_end("@function.outer", "textobjects") end)
    km.nmap("[C", function() m.goto_previous_end("@class.outer", "textobjects") end)
    km.nmap("[A", function() m.goto_previous_end("@parameter.inner", "textobjects") end)
  end,
}
