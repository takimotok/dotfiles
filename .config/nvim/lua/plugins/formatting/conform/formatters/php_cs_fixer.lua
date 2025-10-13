local M = {}

---@type string[]
M.append_args = { "--config" }

---@type string[]
M.files = {
  ".php-cs-fixer.php",
  ".php-cs-fixer.dist.php",
}

return M
