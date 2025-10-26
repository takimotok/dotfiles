local M = {}

-- Usage:
-- 	local km = require("util.key_mapper")
-- 	km.nmap("<F2>", 'i<C-R>=strftime("%H:%M")<CR>', { desc = "insert time" })

local local_opts = { noremap = true, silent = true }
for _, mode in pairs({ "n", "v", "i", "s", "o", "c", "t", "x" }) do
  M[mode .. "map"] = function(lhs, rhs, opts)
    local merged_opts = {}
    for k, v in pairs(opts or {}) do
      merged_opts[k] = v
    end

    for k, v in pairs(local_opts) do
      merged_opts[k] = v
    end

    vim.keymap.set(mode, lhs, rhs, merged_opts)
  end
end

return M
