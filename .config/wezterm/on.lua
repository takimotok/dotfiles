local tab_styles = require("tab_styles")
local wezterm = require("wezterm")

-- tab title
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  return tab_styles.format_tab_title(tab, max_width)
end)

-- set status on the right and decorate it
-- cf.) https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
wezterm.on("update-right-status", function(window, _)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime("%a %b %-d  %H:%M ")

  window:set_right_status(wezterm.format({
    { Text = date },
  }))
end)

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

-- toggle legatures
-- https://wezfurlong.org/wezterm/config/lua/window/set_config_overrides.html?h=ligatures
wezterm.on("toggle-ligature", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    -- If we haven't overridden it yet, then override with ligatures disabled
    overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  else
    -- else we did already, and we should disable out override now
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end)
