return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "folke/snacks.nvim", -- optional
  },
  cmd = {
    "Neogit",
    "NeogitCommit",
    "NeogitLogCurrent",
    "NeogitResetState",
  },
  opts = {
    auto_refresh = true,
    kind = "tab",
    commit_popup = {
      kind = "vsplit",
    },
    preview_buffer = {
      kind = "vsplit",
    },
    popup = {
      kind = "vsplit",
    },
    integrations = {
      diffview = true,
      -- snacks = true,
    },
  },
}
