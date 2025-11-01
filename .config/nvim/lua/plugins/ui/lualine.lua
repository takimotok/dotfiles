local opts = require("plugins.ui.lualine.opts")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = opts,
  config = function(_, user_opts)
    local lualine = require("lualine")

    -- insert CodeCompanion's spinner
    table.insert(user_opts.sections.lualine_y, 1, { require("plugins.ui.lualine.spinner") })

    lualine.setup(user_opts)
  end,
}
