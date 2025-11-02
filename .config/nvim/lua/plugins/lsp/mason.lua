-- TODO: Move away from this plugin and install tools via mise.
-- In my workdflow, this plugins is no longer related to LS packages.

local opts = require("plugins.lsp.mason.opts")

return {
  "mason-org/mason.nvim",
  -- NOTE: ensure set events before lspconfig's setting.
  -- This could be a race condition.
  -- e.g.) I encounted that the `ft` could not be detected when I open a file.
  event = { "BufReadPre", "BufNewFile" },
  opts = opts,
  config = function(_, user_opts)
    -- NOTE: Currently, there's no way to run `ensure_installed` in mason itself.
    -- It seems that there are no plan for it.
    -- @see: https://github.com/mason-org/mason.nvim/pull/1949#pullrequestreview-2853679405
    -- Since the reason above, I implement the installation logic for Formatters, Linters, DAPs and AI related tools.
    -- Note that we can install Language Servers with `ensure_installed` in `mason-lspconfig`.
    require("mason").setup(user_opts)

    local ok, _ = pcall(function()
      require("plugins.lsp.mason.ensure_installed").install()
    end)

    if not ok then
      vim.notify("🤔 Failed to install packages via mason.", vim.log.levels.ERROR)
    end
  end,
}
