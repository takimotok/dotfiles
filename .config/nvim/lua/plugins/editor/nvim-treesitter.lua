return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false, -- last release is way too old
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  -- cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts = {
    -- ensure_installed = {},
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
