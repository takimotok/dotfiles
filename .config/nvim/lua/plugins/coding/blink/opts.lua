local keymap = {
  -- @see: https://cmp.saghen.dev/configuration/keymap#default
  preset = "default", -- 'default' | 'super-tab' | 'enter'

  -- keymaps
  ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
  ["<C-e>"] = { "hide" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = {
    "snippet_forward",
    -- function() -- sidekick next edit suggestion
    --   return require("sidekick").nes_jump_or_apply()
    -- end,
    function()
      if not vim.lsp.inline_completion then
        return nil
      end

      return vim.lsp.inline_completion.get()
    end,
    "select_and_accept",
    "fallback",
  },
  ["<S-Tab>"] = { "snippet_backward", "fallback" },

  -- selection
  ["<C-j>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback" },

  -- scrolling
  ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  ["<C-u>"] = { "scroll_documentation_up", "fallback" },
}

local completion = {
  menu = {
    enabled = true,
    min_width = 15,
    max_height = 10,
    border = "single",
    winblend = 0,
    winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
    scrolloff = 2,
    scrollbar = true,
    draw = {
      columns = {
        { "label", "label_description", gap = 1 },
        { "kind_icon", "kind", gap = 1 },
      },
    },
  },
  documentation = {
    auto_show = true, -- show document automatically
    auto_show_delay_ms = 500,
    update_delay_ms = 50,
    window = {
      border = "single",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:Visual,Search:None",
    },
  },
  ghost_text = {
    enabled = false, -- diabled ghost test
  },
  accept = {
    create_undo_point = true, -- create undo point when completion accepted
    auto_brackets = {
      enabled = true,
    },
  },
}

local appearance = {
  use_nvim_cmp_as_default = true,
  nerd_font_variant = "mono", -- icon kinds
  kind_icons = {
    Snippet = "󰩫",
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
  },
}

local sources = {
  default = { "lazydev", "lsp", "path", "snippets", "buffer", "copilot" },
  -- per_filetype = {
  --   codecompanion = { "codecompanion" },
  -- },
  providers = {
    copilot = {
      name = "copilot",
      module = "blink-cmp-copilot",
      score_offset = 100, -- copilot を優先
      async = true,
      -- kind = nil, -- explicity excluded kind field
      enabled = function()
        local disabled_filetypes = { [""] = true, ["markdown"] = true, ["codecompanion"] = true }
        return not disabled_filetypes[vim.bo.filetype]
      end,
    },
    -- for better lua_ls annotations
    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      -- make lazydev completions top priority
      -- @see `:h blink.cmp`
      score_offset = 100,
    },
  },
}

local snippets = {
  preset = "luasnip",
}

local signature = {
  enabled = true,
  window = {
    border = "single",
    winblend = 0,
    winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
  },
}

-- M.opts = {
local M = {
  keymap = keymap,
  completion = completion,
  -- cmdline = cmdline,
  appearance = appearance,
  sources = sources,
  snippets = snippets,
  signature = signature,
  fuzzy = { implementation = "prefer_rust" },
}

return M
