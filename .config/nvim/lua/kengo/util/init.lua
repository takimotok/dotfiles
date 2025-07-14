local fs = require("conform.fs")
local M = {}

function M.merge_tables(t1, t2)
  local merged = {}
  for _, v in ipairs(t1) do
    table.insert(merged, v)
  end
  for _, v in ipairs(t2) do
    table.insert(merged, v)
  end
  return merged
end

---build context
---cf.) conform.nvim/lua/conform/runner.lua
---@param bufnr integer
---@return kengo.Context
M.build_context = function(bufnr)
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Hack around checkhealth. For buffers that are not files, we need to fabricate a filename
  if vim.bo[bufnr].buftype ~= "" then
    filename = ""
  end
  local dirname
  if filename == "" then
    dirname = vim.fn.getcwd()
    filename = fs.join(dirname, "unnamed_temp")
    local ft = vim.bo[bufnr].filetype
    if ft and ft ~= "" then
      filename = filename .. "." .. ft
    end
  else
    dirname = vim.fs.dirname(filename)
  end

  return {
    buf = bufnr,
    filename = filename,
    dirname = dirname,
  }
end

return M
