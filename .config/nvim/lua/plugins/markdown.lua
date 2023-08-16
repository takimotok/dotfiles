return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        disable_filename = 1,
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    build = ":call mkdp#util#install()",
  },
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = {
      "godlygeek/tabular",
    },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_auto_insert_bullets = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_edit_url_in = "tab"
      -- vim.g.vim_markdown_fenced_languages = {
      --   'bash=bash',
      --   'js=javascript',
      --   'ts=javascript',
      --   'sh=zsh',
      --   'py=python',
      --   'java'
      -- }
      -- keymaps
      -- h.nmap('<leader>gx', '<Plug>Markdown_OpenUrlUnderCursor<cr>',
      --   { desc = 'open the link under the cursor in the same browser as the standard gx command.' })
    end,
  },
  {
    "mattn/vim-maketable",
    ft = { "markdown" },
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      vim.g.table_mode_corner_corner = "+"
      vim.g.table_mode_delimiter = ","
      vim.g.table_mode_header_fillchar = "="
    end,
  },
  -- {
  --   'vimwiki/vimwiki',
  --   ft = {'markdown'},
  --   config = function()
  --     vim.g.vimwiki_global_ext = 0
  --     vim.g.vimwiki_list = {
  --       {
  --         path = '/Users/takimoto/Dropbox/Vault',
  --         syntax = 'markdown',
  --         ext = '.md',
  --         -- index = 'index',
  --         -- auto_toc = 1,
  --       },
  --     --   -- {
  --     --   --   path = '~/takimoto.kengo@gmail.com - Google Drive/My Drive/Vault/',
  --     --   --   ext = '.md',
  --     --   --   syntax = 'markdown',
  --     --   --   index = 'index',
  --     --   --   auto_toc = 1,
  --     --   -- },
  --     }
  --   end,
  -- },
}
