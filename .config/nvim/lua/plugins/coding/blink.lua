local config_blink_cmp = require("kengo.config.plugins.coding.blink-cmp")

return {
  "Saghen/blink.cmp",
  lazy = true,
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
    "Saghen/blink.compat",
  },
  opts = function(_, opts)
    local base_opts = config_blink_cmp.opts

    -- kindフィールドを削除
    if base_opts.sources and base_opts.sources.providers and base_opts.sources.providers.copilot then
      base_opts.sources.providers.copilot.kind = nil
    end

    -- copilot provider 設定 (no kind field)
    opts.sources.providers.copilot = {
      name = "copilot",
      module = "blink-cmp-copilot",
      score_offset = 100,
      async = true,
      -- explicity excluded kind field
    }

    return base_opts
  end,
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- カスタムハイライトを適用
    require("kengo.config.ui.blink_highlights").setup()
  end,
}
