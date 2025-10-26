return {
  "nvim-mini/mini.ai",
  version = "*",
  opts = function(_, opts)
    -- local ai = require("mini.ai")
    opts.custom_textobjects = opts.custom_textobjects or {}

    -- enable some motion like: `yi*`, `va*`, etc...
    opts.custom_textobjects["*"] = { "%*().-()%*" }
    return opts
  end,
}
