local M = {}

--- notify errors
---@param message string error message
---@param info table<string, any> return value of debug.info()
function M.error(message, info)
  -- if not message then
  --   return
  -- end

  -- if not info or #info == 0 then
  --   return
  -- end

  vim.notify("🤔 Error: " .. message, vim.log.levels.ERROR, {
    title = string.format(
      "File: %s | Function: %s | Line: %d",
      info.short_src or info.source,
      info.name or "unknown",
      info.currentline or -1
    ),
  })
end

return M
