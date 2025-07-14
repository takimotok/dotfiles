local utils = require("kengo.config.plugins.linting.nvim-lint.utils")

---@type table<kengo.LinterName, lint.Linter|fun():lint.Linter>
return utils.setup()
