local icons = require("util.icons")
local M = {}

M = {
  lualine_a = { "mode" },
  lualine_b = { "branch" },
  lualine_c = {
    {
      "diagnostics",

      -- Table of diagnostic sources, available sources are:
      --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
      -- or a function that returns a table as such:
      --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
      -- sources = { "nvim_diagnostic", "nvim_lsp" },

      symbols = {
        error = icons.diagnostics.ERROR,
        warn = icons.diagnostics.WARN,
        info = icons.diagnostics.INFO,
        hint = icons.diagnostics.HINT,
      },
    },
  },
  lualine_x = { "encoding", "fileformat", "filetype" },
  lualine_y = {
    { "selectioncount", separator = "", padding = { left = 1, right = 0 } },
    { "location", separator = "", padding = { left = 0, right = 0 } },
    { "progress", padding = { left = 1, right = 1 } },
  },
  lualine_z = {
    function()
      return " " .. os.date("%R")
    end,
  },
}

return M
