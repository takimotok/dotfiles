local M = {}

---@type string[]
M.prepend_args = { "--config" }

---@type string[]
M.files = {
  ".php-cs-fixer.php",
  ".php-cs-fixer.dist.php",
  ".editorconfig",
}

return M
