return {
  -- @see: https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
  -- need tree-sitter-cli
  -- 	`$ cargo install --locked tree-sitter-cli`
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old
  branch = "main",
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  -- cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if vim.treesitter.language.add(lang) then
          vim.treesitter.start()
        end
      end,
    })
  end,
  opts = {
    ensure_installed = "all",
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
