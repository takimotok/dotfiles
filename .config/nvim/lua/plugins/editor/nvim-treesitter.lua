local opts = require("plugins.editor.nvim-treesitter.opts")

return {
  -- @see: https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
  -- need tree-sitter-cli
  -- 	`$ cargo install --locked tree-sitter-cli`
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local nt = require("nvim-treesitter")
    nt.setup({})
    nt.install(opts.languages)

    -- Register the `markdown` parser to be used for `.mdx`
    vim.treesitter.language.register("markdown", { "mdx" })

    -- set highlighting, indentations and folds
    local filetypes = {}
    for _, lang in ipairs(nt.get_available(2)) do
      for _, filetype in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, filetype)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      group = vim.api.nvim_create_augroup("dotfiles.nvim-treesitter-start", {}),
      callback = function()
        -- highlighting
        pcall(vim.treesitter.start)

        -- folds
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        -- indentations
        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end,
    })
  end,
}
