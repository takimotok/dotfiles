local wezterm = require("wezterm")

-- show battery status
-- wezterm.on('update-right-status', function(window, pane)
--   -- "Wed Mar 3 08:14"
--   local date = wezterm.strftime '%a %b %-d %H:%M '
--
--   local bat = ''
--   for _, b in ipairs(wezterm.battery_info()) do
--     -- @TODO: change icon by b.state
--     bat = '🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
--   end
--
--   window:set_right_status(wezterm.format {
--     { Text = ' ' .. bat .. '  ' .. date },
--   })
-- end)

-- tab title
-- @TODO: 2024-07-07: tab 名を変更したら任意の format で反映したい
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   if tab.is_active then
--     return {
--       -- { Background = { Color = 'blue' } },
--       { Text = " " .. tab.active_pane.title .. " " },
--     }
--   end
--   return tab.active_pane.title
-- end)

-- set status on the right and decorate it
wezterm.on("update-right-status", function(window, pane)
  local cells = {}

  -- pick up remote host
  -- local cwd_uri = pane:get_current_working_dir()

  -- battery
  local bat = ""
  for _, b in ipairs(wezterm.battery_info()) do
    bat = "🔋" .. string.format("%.0f%%", b.state_of_charge * 100)
  end

  local elements = {}
  window:set_right_status(wezterm.format(elements))
end)

-- @TODO: change icon by b.state
local function bat()
  local bat = ""
  for _, b in ipairs(wezterm.battery_info()) do
    bat = "🔋" .. string.format("%.0f%%", b.state_of_charge * 100)
  end

  return bat
end

-- cf.) https://wezfurlong.org/wezterm/config/lua/wezterm/on.html
wezterm.on("trigger-vim-with-visible-text", function(window, pane)
  -- Retrieve the current viewport's text.
  local viewport_text = pane:get_lines_as_text()

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, "w+")
  f:write(viewport_text)
  f:flush()
  f:close()

  -- Open a new window running vim and tell it to open the file
  window:perform_action(
    wezterm.action.SpawnCommandInNewWindow({
      -- args = { 'vim', name },
      args = { "nvim", name },
    }),
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)
