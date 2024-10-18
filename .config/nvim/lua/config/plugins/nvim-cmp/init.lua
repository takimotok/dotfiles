require("copilot_cmp").setup()

local M = {}

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("luasnip.loaders.from_snipmate").lazy_load()

local source_map = {
  buffer = "Buffer",
  calc = "Calc",
  copilot = "Copilot",
  luasnip = "LuaSnip",
  nvim_lsp = "LSP",
  nvim_lsp_signature_help = "Signature",
  path = "Path",
  dap = "Dap",
}

M.source_group_first = {
  { name = "nvim_lsp" },
  { name = "nvim_lsp_signature_help" },
  { name = "dap" },
  { name = "copilot" },
  { name = "path" },
  { name = "cmdline" },
}
M.source_group_second = {
  {
    name = "buffer",
    option = {
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
    },
  },
}
M.source_group_third = {
  { name = "calc" },
  { name = "emoji" },
  { name = "luasnip" },
  { name = "treesitter" },
  {
    name = "dictionary",
    keyword_length = 2,
  },
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = { name = "custom", selection_order = "near_cursor" },
  },
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-[>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  }),
  sources = cmp.config.sources(M.source_group_first, M.source_group_second, M.source_group_third),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        symbol_map = {
          Copilot = "",
        },
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      -- Replace the 'menu' field with the source
      kind.menu = " (" .. (source_map[entry.source.name] or entry.source.name) .. ")"

      return kind
    end,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
