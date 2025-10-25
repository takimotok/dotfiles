local M = {}

M.ui = {
  -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
  -- Defaults to `:h 'winborder'` if nil.
  border = "single",

  -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
  backdrop = 20,

  -- Width of the window. Accepts:
  -- - Integer greater than 1 for fixed width.
  -- - Float in the range of 0-1 for a percentage of screen width.
  width = 0.8,

  -- Height of the window. Accepts:
  -- - Integer greater than 1 for fixed height.
  -- - Float in the range of 0-1 for a percentage of screen height.
  height = 0.9,
}

return M
