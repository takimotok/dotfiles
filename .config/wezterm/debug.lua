local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'

-- right status
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%a %b %-d %H:%M ' -- "Wed Mar 3 08:14"

  window:set_right_status(wezterm.format {
    { Text = wezterm.nerdfonts.mdi_clock .. ' ' .. date },
  })
end)

-- local hostname = wezterm.hostname()
-- print("hostname = " .. hostname) -- mbp2019


-- wezterm.log_info('Config file ' .. wezterm.config_file)
-- wezterm.log_error('Exe dir ' .. wezterm.executable_dir) -- /usr/local/bin

-- wezterm.log_info(wezterm.format {
--   { Attribute = { Underline = 'Single' } },
--   { Foreground = { AnsiColor = 'Fuchsia' } },
--   { Background = { Color = 'blue' } },
--   { Text = 'Config file = ' .. wezterm.config_file .. ' ' },
--   -- ResetAttributes 以降は, 上記までの font 設定がリセットされる
--   -- だから, 下記 Text は装飾なしになる
--   'ResetAttributes',
--   { Text = wezterm.executable_dir },
-- })

-- err. だけど, wezterm.lua で実行したらできた
-- path = wezterm.home_dir
-- for _, v in ipairs(wezterm.glob(path .. '/*')) do
--   wezterm.log_error('entry: ' .. v)
-- end


-- {
--   key = 'i',
--   mods = 'CTRL|SHIFT',
--   action = wezterm.action_callback(function(win, pane)
--     wezterm.log_info 'Hello from callback!'
--     wezterm.log_info(
--       'WindowID:',
--       win:window_id(),
--       'PaneID:',
--       pane:pane_id()
--       )
--     end),
--   },
