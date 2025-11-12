local md_filetypes = require("util").md_filetypes

local M = {
  file_types = md_filetypes,

  -- https://github.com/olimorris/codecompanion.nvim/discussions/456
  render_modes = true, -- render in all modes
  sign = {
    enabled = false, -- Turn off in the status column
  },
  heading = require("plugins.coding.markdown.render-markdown.heading"),
  bullet = require("plugins.coding.markdown.render-markdown.bullet"),
  callout = require("plugins.coding.markdown.render-markdown.callout"),
  checkbox = require("plugins.coding.markdown.render-markdown.checkbox"),
  code = require("plugins.coding.markdown.render-markdown.code"),
  latex = require("plugins.coding.markdown.render-markdown.latex"),
  link = require("plugins.coding.markdown.render-markdown.link"),
  pipe_table = require("plugins.coding.markdown.render-markdown.pipe_table"),
}

return M
