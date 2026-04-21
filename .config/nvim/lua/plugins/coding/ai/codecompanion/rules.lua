local M = {
  default = {
    description = "Collection of common files for all projects",
    files = {
      ".clinerules",
      ".cursorrules",
      ".goosehints",
      ".rules",
      ".windsurfrules",
      ".github/copilot-instructions.md",
      "AGENT.md",
      "AGENTS.md",
      "~/.config/copilot/AGENTS.md",
      { path = "CLAUDE.md", parser = "claude" },
      { path = "CLAUDE.local.md", parser = "claude" },
      { path = "~/.claude/CLAUDE.md", parser = "claude" },
      { path = "~/.config/claude/CLAUDE.md", parser = "claude" },
    },
    is_preset = true,
  },
  opts = {
    chat = {
      autoload = { "default" },
    },
  },
}

return M
