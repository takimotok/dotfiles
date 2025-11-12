local km = require("util.key_mapper")
local md_filetypes = require("util").md_filetypes
local opts = require("plugins.coding.markdown.render-markdown.opts")

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = md_filetypes,
  opts = opts,
  config = function(_, user_opts)
    local rm = require("render-markdown")
    rm.setup(user_opts)

    -- key mappings
    km.nmap("<leader>um", function()
      rm.buf_toggle()
    end, { desc = "Toggle RenderMarkdown" })
  end,
}
