return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
  },
  config = function(_, opts)
    require("aerial").setup(opts)

    -- Set Everforest colors for aerial after the theme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "everforest",
      callback = function()
        -- Basic aerial highlight groups
        vim.api.nvim_set_hl(0, "AerialLine", { link = "CursorLine" })
        vim.api.nvim_set_hl(0, "AerialLineNC", { link = "Visual" })
        vim.api.nvim_set_hl(0, "AerialGuide", { link = "Comment" })

        -- Symbol kind highlights using Everforest palette
        vim.api.nvim_set_hl(0, "AerialClassIcon", { fg = "#a7c080" }) -- green
        vim.api.nvim_set_hl(0, "AerialClass", { link = "Type" })
        vim.api.nvim_set_hl(0, "AerialFunctionIcon", { fg = "#e67e80" }) -- red
        vim.api.nvim_set_hl(0, "AerialFunction", { link = "Function" })
        vim.api.nvim_set_hl(0, "AerialMethodIcon", { fg = "#d699b6" }) -- purple
        vim.api.nvim_set_hl(0, "AerialMethod", { link = "Function" })
        vim.api.nvim_set_hl(0, "AerialStructIcon", { fg = "#83c092" }) -- cyan
        vim.api.nvim_set_hl(0, "AerialStruct", { link = "Type" })
        vim.api.nvim_set_hl(0, "AerialEnumIcon", { fg = "#dbbc7f" }) -- yellow
        vim.api.nvim_set_hl(0, "AerialEnum", { link = "Type" })
        vim.api.nvim_set_hl(0, "AerialModuleIcon", { fg = "#7fbbb3" }) -- aqua
        vim.api.nvim_set_hl(0, "AerialModule", { link = "Include" })
        vim.api.nvim_set_hl(0, "AerialInterfaceIcon", { fg = "#d699b6" }) -- purple
        vim.api.nvim_set_hl(0, "AerialInterface", { link = "Type" })
        vim.api.nvim_set_hl(0, "AerialConstructorIcon", { fg = "#e69875" }) -- orange
        vim.api.nvim_set_hl(0, "AerialConstructor", { link = "Function" })
      end,
    })

    -- Trigger the autocmd immediately if Everforest is current colorscheme
    if vim.g.colors_name == "everforest" then
      vim.cmd("doautocmd ColorScheme everforest")
    elseif vim.g.colors_name == "tokyonight-night" then
      vim.cmd("doautocmd ColorScheme tokyonight-night")
    end
  end,
}
