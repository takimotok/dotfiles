return {
  init_options = {
    ["language_server_php_cs_fixer.enabled"] = false,
    ["language_server_phpstan.enabled"] = false,
  },
  root_markers = { "composer.json", ".git" },
  filetypes = { "php" },
}