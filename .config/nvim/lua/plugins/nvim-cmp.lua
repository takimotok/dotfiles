return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    cmd = { "CmpStatus" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "ray-x/cmp-treesitter",
      "rcarriga/cmp-dap",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      -- "uga-rosa/cmp-dictionary",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      require("copilot_cmp").setup()

      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      require("luasnip/loaders/from_snipmate").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-[>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Replace,
          }),
        }),
        sources = cmp.config.sources({
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "calc" },
          { name = "cmdline" },
          { name = "copilot" },
          { name = "emoji" },
          { name = "luasnip" },
          {
            name = "nvim_lsp",
            max_item_count = 200,
          },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "treesitter" },
          { name = "dap" },
          {
            name = "dictionary",
            keyword_length = 2,
          },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            max_width = 50,
            symbol_map = {
              Copilot = "",
            },
            menu = {
              buffer = "[Buffer]",
              calc = "[Calc]",
              copilot = "[Copilot]",
              luasnip = "[LuaSnip]",
              nvim_lsp = "[LSP]",
              nvim_lsp_signature_help = "[Signature]",
              path = "[Path]",
              dap = "[Dap]",
            },
          }),
        },
      })

      -- @TODO: think later
      -- Set configuration for specific filetype.
      -- cmp.setup.filetype("gitcommit", {
      --   sources = cmp.config.sources(
      --     {
      --       -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      --       { name = "git" },
      --     },
      --     {
      --       { name = "buffer" },
      --     }
      --   )
      -- })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- local dict = require("cmp_dictionary")
      -- dict.setup({
      --   -- The following are default values.
      --   exact = 2,
      --   first_case_insensitive = false,
      --   document = false,
      --   document_command = "wn %s -over",
      --   sqlite = false,
      --   max_items = -1,
      --   capacity = 5,
      --   debug = false,
      -- })
    end,
  },
}
