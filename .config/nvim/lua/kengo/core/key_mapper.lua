local util = require("kengo.util")

local M = {}

local local_opts = { noremap = true, silent = true }
for _, mode in pairs({ "n", "v", "i", "s", "o", "c", "t", "x" }) do
  M[mode .. "map"] = function(lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, util.merge_tables(opts, local_opts))
  end
end

return M
