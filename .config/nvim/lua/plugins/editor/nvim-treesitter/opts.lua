local M = {}

M.languages = {
  -- for shellscripts
  "bash",
  -- for html, css
  "html",
  "css",
  "scss",
  -- for docker
  "dockerfile",
  -- for git
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  -- for lua
  "lua",
  "luadoc", -- Lua docs grammar
  "luap", -- Lua patterns grammar
  -- for go
  "go",
  -- for java
  "java",
  "javadoc",
  -- for kotolin
  "kotolin",
  -- for swift
  "swift",
  -- for js
  "javascript",
  "jsdoc",
  "typescript", -- for TypeScript grammar
  "tsx", -- for TSX grammar
  "vue",
  -- for markdown
  "markdown",
  "markdown_inline",
  -- for sql
  "sql",
  -- for php
  "php",
  "phpdoc",
  -- for python
  "python",
  -- for rust
  "rust",
  -- for vim
  "vim",
  "vimdoc",
  -- for general tools and configuration files
  "diff", --A tree-sitter grammar for diffs
  "json",
  "jsonc",
  "json5",
  "latex",
  "make",
  "mermaid",
  "nginx",
  "printf", -- Injectable grammar for printf formats.
  "query", -- for tree-sitter query files
  "regex", -- for regular expressoins
  "tmux",
  "toml",
  "xml",
  "ssh_config",
  "yaml",
}

return M
