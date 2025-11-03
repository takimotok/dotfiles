-- for CodeCompanin-history
-- @see: https://github.com/Davidyz/VectorCode/blob/main/docs/neovim/README.md#installation
return {
  "Davidyz/VectorCode",
  version = "*",
  -- NOTE: need to run `$ uv tool install vectorcode` at first time
  -- The CLI path is add in `.config/zsh/rc/07-others.zsh`
  build = "uv tool upgrade vectorcode",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
}
