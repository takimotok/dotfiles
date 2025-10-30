return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      mode = "tabs",
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
      -- e.g.) diagnostics_indicator
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
      --     return "("..count..")"
      -- end,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("util.icons").diagnostics
        local ret = (diag.error and icons.ERROR .. diag.error .. " " or "")
          .. (diag.warning and icons.WARN .. diag.warning or "")
          .. (diag.hint and icons.HINT .. diag.hint or "")
        return vim.trim(ret)
      end,
    },
  },
}
