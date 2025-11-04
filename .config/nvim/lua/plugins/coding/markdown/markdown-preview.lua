local md_filetypes = require("util").md_filetypes

return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  -- @see: ~/.local/state/nvim/lazy/readme/doc/markdown-preview.nvim.md
  -- @see: https://github.com/iamcco/markdown-preview.nvim/issues/695
  build = "cd app && yarn install",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = md_filetypes,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
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
