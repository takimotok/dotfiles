local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

module = {
  --[[ custum events ]]
  {
    key = "v",
    mods = "LEADER",
    action = act.EmitEvent("trigger-vim-with-visible-text"),
  },

  --[[ activate modes ]]
  {
    key = "[",
    mods = "LEADER",
    action = act.ActivateCopyMode,
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
    }),
  },

  --[[ panes ]]
  -- split
  {
    key = "%",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = '"',
    mods = "LEADER|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  -- select
  {
    key = "s",
    mods = "LEADER",
    action = act.PaneSelect({
      alphabet = "1234567890",
    }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },

  -- rotate
  {
    key = "Space",
    mods = "LEADER",
    action = act.RotatePanes("CounterClockwise"),
  },
  {
    key = "H",
    mods = "LEADER | SHIFT",
    action = act.RotatePanes("Clockwise"),
  },
  {
    key = "L",
    mods = "LEADER | SHIFT",
    action = act.RotatePanes("CounterClockwise"),
  },

  -- close
  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- zoom
  {
    key = "z",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },

  --[[ tabs ]]
  -- list tabs like tmux's `show windows`
  {
    key = 't',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },

  -- select
  { key = "j", mods = "LEADER|SHIFT", action = act.ActivateTabRelativeNoWrap(1) },
  { key = "k", mods = "LEADER|SHIFT", action = act.ActivateTabRelativeNoWrap(-1) },

  -- spawn (same as `Command + t`)
  -- { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

  -- rename current tab name
  -- cf.) https://wezfurlong.org/wezterm/config/lua/keyassignment/PromptInputLine.html#example-of-interactively-renaming-the-current-tab
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = 'Enter new tab name:',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  --[[ window ]]
  { key = "f", mods = "CTRL|CMD", action = act.ToggleFullScreen },

  --[[ workspaces ]]
  -- list
  {
    key = "w",
    mods = "LEADER",
    action = act.ShowLauncherArgs({
      flags = "WORKSPACES",
      title = "Select workspace",
    }),
  },

  -- Switch between workspaces
  -- @TODO: 2024-07-07 これ, 理解する
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local workspaces = {}
      for i, name in ipairs(wezterm.mux.get_workspace_names()) do
        table.insert(workspaces, {
          id = name,
          label = string.format("%d. %s", i, name),
        })
      end
      local current = wezterm.mux.get_active_workspace()
      win:perform_action(
        act.InputSelector({
          action = wezterm.action_callback(function(_, _, id, label)
            if not id and not label then
              wezterm.log_info("Workspace selection canceled")
            else
              win:perform_action(act.SwitchToWorkspace({ name = id }), pane)
            end
          end),
          title = "Switch workspace",
          choices = workspaces,
          fuzzy = true,
          fuzzy_description = string.format("Switch workspace: %s -> ", current), -- requires nightly build
        }),
        pane
      )
    end),
  },


  -- create
  {
    key = "W",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = "(wezterm) Create new workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace({
              name = line,
            }),
            pane
          )
        end
      end),
    }),
  },

  -- rename
  {
    key = 'F2',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = '(wezterm) Enter workspace name:',
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
  },

  -- select
  { key = 'n', mods = 'LEADER', action = act.SwitchWorkspaceRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.SwitchWorkspaceRelative(-1) },

}

-- move tabs to specified position
local moves = {}
for i = 1, 9 do
  table.insert(moves, {
    key = tostring(i),
    mods = "LEADER",
    action = act.MoveTab(i - 1),
  })

  table.insert(module, moves[i])
end

return module
