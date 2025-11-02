return {
  "ravitemer/mcphub.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "Joakker/lua-json5",
      -- manually executed in $XDG_DATA_HOME/nvim/lazy/lua-json5
      -- due to not work `build` spec
      -- e.g.)
      --  $ cd $XDG_DATA_HOME/nvim/lazy/lua-json5
      --  $ ./install.sh
      build = "./install.sh",
    },
  },
  -- install `mcp-hub` node binary globally by mise
  -- @see ~/.config/mise/config.toml
  build = "mise use -g npm:mcp-hub@latest",
  config = function()
    require("mcphub").setup({
      json_decode = require("json5").parse,
    })
  end,
}
