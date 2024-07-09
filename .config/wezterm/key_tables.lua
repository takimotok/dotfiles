local wezterm = require("wezterm")
local module = {}

module = {
  resize_pane = {
    { key = "H", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
    { key = "L", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
    { key = "K", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
    { key = "J", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "[", mods = "LEADER", action = "PopKeyTable" },
  },
  copy_mode = {
    -- quit
    { key = "Escape", mods = "NONE", action = wezterm.action.CopyMode("Close") },
    { key = "q", mods = "NONE", action = wezterm.action.CopyMode("Close") },
    { key = "q", mods = "NONE", action = wezterm.action.CopyMode("Close") },

    -- moving cursor
    { key = "h", mods = "NONE", action = wezterm.action.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = wezterm.action.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = wezterm.action.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = wezterm.action.CopyMode("MoveRight") },
    { key = "n", mods = "CTRL", action = wezterm.action.CopyMode("MoveDown") },
    { key = "p", mods = "CTRL", action = wezterm.action.CopyMode("MoveUp") },
    { key = "LeftArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveLeft") },
    { key = "RightArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveRight") },
    { key = "UpArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveUp") },
    { key = "DownArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveDown") },
    { key = "b", mods = "NONE", action = wezterm.action.CopyMode("MoveBackwardWord") },
    { key = "B", mods = "NONE", action = wezterm.action.CopyMode("MoveBackwardWord") },
    { key = "e", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
    { key = "E", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
    { key = "w", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
    { key = "Tab", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
    { key = "Tab", mods = "SHIFT", action = wezterm.action.CopyMode("MoveBackwardWord") },
    { key = "$", mods = "NONE", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
    { key = "$", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
    { key = "0", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfLine") },
    { key = "^", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
    { key = "^", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
    { key = "Enter", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfNextLine") },

    -- moving cursor inside viewport
    { key = "H", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportTop") },
    { key = "H", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportTop") },
    { key = "L", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportBottom") },
    { key = "L", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportBottom") },
    { key = "M", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportMiddle") },
    { key = "M", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportMiddle") },
    { key = "z", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportMiddle") },

    -- scrolling
    { key = "g", mods = "NONE", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
    { key = "G", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
    { key = "e", mods = "CTRL", action = wezterm.action.ScrollByLine(1) },
    { key = "y", mods = "CTRL", action = wezterm.action.ScrollByLine(-1) },
    { key = "b", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },
    { key = "PageUp", mods = "NONE", action = wezterm.action.CopyMode("PageUp") },
    { key = "f", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },
    { key = "PageDown", mods = "NONE", action = wezterm.action.CopyMode("PageDown") },
    { key = "u", mods = "CTRL", action = wezterm.action.ScrollByPage(-0.5) },
    { key = "d", mods = "CTRL", action = wezterm.action.ScrollByPage(0.5) },

    -- selection mode
    { key = "Space", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "V", mods = "SHIFT", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "v", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "v", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) },

    -- {
    --   key = 'Enter' ,
    --   mods = 'NONE' ,
    --   action = wezterm.action.Multiple{
    --     { CopyTo =  'ClipboardAndPrimarySelection' },
    --     { CopyMode =  'Close' }
    --   }
    -- },
    { key = "O", mods = "NONE", action = wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz") },
    { key = "O", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz") },
    { key = "o", mods = "NONE", action = wezterm.action.CopyMode("MoveToSelectionOtherEnd") },

    {
      key = "y",
      mods = "NONE",
      action = wezterm.action.Multiple({
        { CopyTo = "ClipboardAndPrimarySelection" },
        { CopyMode = "Close" },
      }),
    },

    -- seaching
    -- `/` で search mode に入って, `CTRL-[` で copy mode に戻る
    -- さらに, copy mode で `CTRL-[` or `Escape` で copy mode から抜ける のはどうだろう ?
    { key = "/", mods = "NONE", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
    {
      key = "n",
      mods = "NONE",
      action = wezterm.action.Multiple({
        wezterm.action.CopyMode("NextMatch"),
        wezterm.action.CopyMode("ClearSelectionMode"),
      }),
    },
    {
      key = "N",
      mods = "SHIFT",
      action = wezterm.action.Multiple({
        wezterm.action.CopyMode("PriorMatch"),
        wezterm.action.CopyMode("ClearSelectionMode"),
      }),
    },
  },

  -- search_mode = {
  -- },
}

return module
