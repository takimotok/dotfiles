local function custom_highlights(colors)
  return {
    -- Comment = { fg = "#E6E6E6" },
    Comment = { fg = colors.green },
  }
end

local opts = {
  flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
  background = {
    light = "latte",
    dark = "mocha",
  },
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  transparent_background = true,
  show_end_of_buffer = false,
  term_colors = true,
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
  styles = {
    comments = { "italic" },
    functions = { "bold" },
    keywords = { "italic" },
    operators = { "bold" },
    conditionals = { "bold" },
    loops = { "bold" },
    booleans = { "bold", "italic" },
    numbers = {},
    types = {},
    strings = {},
    variables = {},
    properties = {},
  },
  integrations = {
    cmp = true,
    dap = { enabled = true, enable_ui = true },
    gitsigns = true,
    markdown = true,
    mason = true,
    neogit = true,
    neotest = true,
    treesitter = true,
    treesitter_context = true,
    telescope = {
      enabled = true,
    },
    which_key = true,
    ts_rainbow = true,
    ts_rainbow2 = true,
  },
  custom_highlights = custom_highlights(colors),
}

return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  build = ":CatppuccinCompile",
  opts = opts,
  config = function (_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end
}

