local md_filetypes = require("util").md_filetypes

return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  init = function()
    vim.g.mkdp_theme = "light"
    vim.g.mkdp_preview_options = {
      disable_filename = 1,
    }
  end,

  -- write down one of below if TOC is needed
  -- ${toc}
  -- [[toc]]
  -- [toc]
  -- [[_toc_]]
}
