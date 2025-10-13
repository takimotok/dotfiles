local config_blink_cmp = require("kengo.config.plugins.coding.blink-cmp")

return {
  "Saghen/blink.cmp",
  lazy = true,
  dependencies = {
    {
      "giuxtaposition/blink-cmp-copilot",
    },
    {
      "Saghen/blink.compat",
    },
  },
  opts = function(_, opts)
    -- 基本設定を取得
    local base_opts = config_blink_cmp.opts

    -- LazyVimのデフォルト設定を上書き
    if base_opts.sources and base_opts.sources.providers and base_opts.sources.providers.copilot then
      -- kindフィールドを削除
      base_opts.sources.providers.copilot.kind = nil
    end

    return base_opts
  end,
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- カスタムハイライトを適用
    require("kengo.config.ui.blink_highlights").setup()
  end,
}
