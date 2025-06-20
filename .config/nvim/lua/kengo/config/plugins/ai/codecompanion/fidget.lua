local progress = require("fidget.progress")

local M = {}

-- Helper function to safely access nested fields
local function safe_get(obj, ...)
  if obj == nil then
    return nil
  end
  local current = obj
  for _, key in ipairs({ ... }) do
    if type(current) ~= "table" then
      return nil
    end
    current = current[key]
    if current == nil then
      return nil
    end
  end
  return current
end

function M:init()
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(event)
      -- Safely extract request ID
      local request_id = safe_get(event, "data", "id")
      if request_id then
        local handle = M:create_progress_handle(event)
        if handle then
          M:store_progress_handle(request_id, handle)
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(event)
      -- Safely extract request ID
      local request_id = safe_get(event, "data", "id")
      if request_id then
        local handle = M:pop_progress_handle(request_id)
        if handle then
          M:report_exit_status(handle, event)
          handle:finish()
        end
      end
    end,
  })
end

M.handles = {}

function M:store_progress_handle(id, handle)
  M.handles[id] = handle
end

function M:pop_progress_handle(id)
  local handle = M.handles[id]
  M.handles[id] = nil
  return handle
end

function M:create_progress_handle(event)
  -- For debugging purposes, uncomment this line:
  -- local data = safe_get(event, "data")
  -- if data then
  --   print("Strategy: " .. vim.inspect(data))
  -- end

  -- Safely determine strategy
  local strategy = safe_get(event, "data", "strategy")
  if not strategy then
    strategy = safe_get(event, "data", "command")
  end
  if not strategy then
    strategy = "assistant" -- Default fallback
  end

  -- Safely get adapter
  local adapter = safe_get(event, "data", "adapter") or {}

  return progress.handle.create({
    title = " Requesting assistance (" .. strategy .. ")",
    message = "In progress...",
    lsp_client = {
      name = M:llm_role_title(adapter),
    },
  })
end

function M:llm_role_title(adapter)
  if not adapter then
    return "AI"
  end

  local parts = {}
  table.insert(parts, adapter.formatted_name or "AI")
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

function M:report_exit_status(handle, event)
  local status = safe_get(event, "data", "status") or "unknown"

  if status == "success" then
    handle.message = "Completed"
  elseif status == "error" then
    handle.message = " Error"
  else
    handle.message = "󰜺 Cancelled"
  end
end

return M

