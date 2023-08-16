local dap_config = require("config.plugins.dap")

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jbyuki/one-small-step-for-vimkind",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      dap_config.setup()
    end,
  },
}
