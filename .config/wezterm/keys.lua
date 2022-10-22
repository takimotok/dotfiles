local wezterm = require 'wezterm'
local module = {}


module = {
  --[[ custum events ]]
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.EmitEvent 'trigger-vim-with-visible-text',
  },

  --[[ activate modes ]]
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },



  --[[ panes ]]
  -- split
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- select
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },

  -- rotate
  {
    key = 'Space',
    mods = 'LEADER',
    action = wezterm.action.RotatePanes 'CounterClockwise',
  },
  {
    key = 'H',
    mods = 'LEADER | SHIFT',
    action = wezterm.action.RotatePanes 'Clockwise',
  },
  {
    key = 'L',
    mods = 'LEADER | SHIFT',
    action = wezterm.action.RotatePanes 'CounterClockwise',
  },

  -- close
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },


  -- zoom
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },


  --[[ tabs ]]
  -- list tabs like tmux's `show windows`
  { key = 'w', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },

  -- move
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelativeNoWrap(-1) },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelativeNoWrap(1) },

  -- spawn
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },


  --[[ window ]]
  { key = 'f', mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen },

}


-- move tabs
local moves = {}
for i = 1, 9 do
  table.insert(moves, {
      key = tostring(i),
      mods = 'LEADER',
      action = wezterm.action.MoveTab(i - 1),
    })

  table.insert(module, moves[i])
end


return module
