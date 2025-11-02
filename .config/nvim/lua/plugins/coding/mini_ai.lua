return {
  "nvim-mini/mini.ai",
  version = "*",
  -- opts = function(_, opts)
  --   -- local ai = require("mini.ai")
  --   opts.custom_textobjects = opts.custom_textobjects or {}
  --
  --   -- enable some motion like: `yi*`, `va*`, etc...
  --   opts.custom_textobjects["*"] = { "%*().-()%*" }
  --   return opts
  -- end,
  opts = function()
    local ai = require("mini.ai")

    return {
      n_lines = 500, -- Number of lines within which textobject is searched
      custom_textobjects = {
        -- for markdown
        -- @see `:h mini.ai#MiniAi.gen_spec.pair()`
        ["*"] = ai.gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = ai.gen_spec.pair("_", "_", { type = "greedy" }),

        -- code block
        c = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        -- function
        f = ai.gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }),
        -- class
        -- c = ai.gen_spec.treesitter({
        --   a = "@class.outer",
        --   i = "@class.inner",
        -- }),
        -- tags
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        -- digits
        d = { "%f[%d]%d+" },
        -- Word with case
        e = {
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        -- buffer
        -- g = LazyVim.mini.ai_buffer,
        -- u for "Usage"
        -- u = ai.gen_spec.function_call(),
        -- without dot in function name
        -- U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
      },
    }
  end,

  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}
