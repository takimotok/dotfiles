local opts = require("plugins.coding.blink.opts")

-- debug start
-- vim.notify("blink opts: " .. vim.inspect(opts))
-- debug end

return {
  {
    "Saghen/blink.compat",
    lazy = true,
  },
  {
    "Saghen/blink.cmp",
    lazy = true,
    build = "cargo build --release",
    dependencies = {
      "giuxtaposition/blink-cmp-copilot",
    },
    opts = opts,
    config = function(_, user_opts)
      require("blink.cmp").setup(user_opts)

      -- apply custom hilight
      require("plugins.coding.blink.highlights").setup()
    end,
  },
}
