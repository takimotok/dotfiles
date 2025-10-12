local M = {}

local keymap = {
  preset = "default", -- 'default' | 'super-tab' | 'enter'

  -- keymaps
  ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
  ["<C-e>"] = { "hide" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = {
    "snippet_forward",
    function() -- sidekick next edit suggestion
      return require("sidekick").nes_jump_or_apply()
    end,
    -- function() -- if you are using Neovim's native inline completions
    --   return vim.lsp.inline_completion.get()
    -- end,
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
    border = "none",
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
      border = "rounded",
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
  default = { "lsp", "path", "snippets", "buffer", "copilot" },
  providers = {
    copilot = {
      name = "copilot",
      module = "blink-cmp-copilot",
      score_offset = 100, -- copilot を優先
      async = true,
    },
  },
}

local snippets = {
  preset = "luasnip",
}

local signature = {
  enabled = true,
  window = {
    border = "rounded",
    winblend = 0,
    winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
  },
}

M.opts = {
  keymap = keymap,
  completion = completion,
  appearance = appearance,
  sources = sources,
  snippets = snippets,
  signature = signature,
}

return M
