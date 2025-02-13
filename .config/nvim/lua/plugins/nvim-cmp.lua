return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    cmd = { "CmpStatus" },
    dependencies = {
      -- sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "rcarriga/cmp-dap",
      "saadparwaiz1/cmp_luasnip",
      "zbirenbaum/copilot-cmp",

      -- snippets
      "L3MON4D3/LuaSnip",

      -- pictograms
      "onsails/lspkind.nvim",
    },
    config = function()
      require("config.plugins.nvim-cmp")
    end,
  },
}
