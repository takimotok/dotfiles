local M = {
  dotfiles_rules = {
    description = "Dotfiles project rules",
    files = {
      "/Users/kengo/projects/github.com/takimotok/dotfiles/.github/copilot-instructions.md",
    },
  },
  opts = {
    chat = {
      autoload = { "default", "dotfiles_rules" },
    },
  },
}

return M
