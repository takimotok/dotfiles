local M = {
  dotfiles_rules = {
    description = "Dotfiles project rules",
    files = {
      "/Users/kengo/projects/github.com/takimotok/dotfiles/.github/instructions/codecompanion-chat-rule-default.md",
    },
  },
  dotfiles_neovim_rules = {
    description = "Dotfiles project rules",
    files = {
      "/Users/kengo/projects/github.com/takimotok/dotfiles/.github/instructions/codecompanion-chat-rule-neovim.md",
    },
  },
  opts = {
    chat = {
      autoload = { "default", "dotfiles_rules" },
    },
  },
}

return M
