local M = {}

-- what buffers to dim
M.filter = function(buf)
  return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
end

return M
