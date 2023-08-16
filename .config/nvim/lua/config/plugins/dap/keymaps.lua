local km = require("core.key_mapper")

local M = {}

function M.setup()
  -- dap
  -- <leader>dl is used to especially in lua language
  km.nmap(
    "<leader>dl",
    [[
        <cmd>lua require("osv").launch({port = 8086})<CR>
        <cmd>lua require("dapui").open()<CR>
    ]]
  )
  km.nmap("<leader>dr", '<cmd>lua require("osv").run_this()<CR>')
  km.nmap("<leader>db", ':lua require("dap").toggle_breakpoint()<CR>')
  km.nmap("<leader>dt", ':lua require("dap").terminate()<CR>')
  km.nmap("<leader>dc", ':lua require("dap").continue()<CR>')
  km.nmap("<M-J>", ':lua require("dap").step_into()<CR>')
  km.nmap("<M-L>", ':lua require("dap").step_over()<CR>')
  km.nmap("<M-K>", ':lua require("dap").step_out()<CR>')
  km.nmap("<M-H>", ':lua require("dap").step_back()<CR>')
  km.nmap("<F12>", ':lua require("dap.ui.widgets").hover()<CR>')

  -- ui
  km.nmap("<leader>dui", ':lua require("dapui").toggle()<CR>')
  km.nmap("<leader>de", ':lua require("dapui").eval()<CR>')

  -- telescope
  require("telescope").load_extension("dap")
  km.nmap("<leader>dls", ":Telescope dap commands<CR>")
  km.nmap("<leader>d,", ":Telescope dap configuration<CR>")
  km.nmap("<leader>dlb", ":Telescope dap lit_breakpoints<CR>")
  km.nmap("<leader>dv", ":Telescope dap variables<CR>")
  km.nmap("<leader>dlf", ":Telescope dap frames<CR>")
end

return M
