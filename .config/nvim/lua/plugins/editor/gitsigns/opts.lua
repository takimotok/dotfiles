local km = require("util.key_mapper")
local M = {}

M = {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    km.nmap("]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, { desc = "Next Hunk" })

    km.nmap("[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, { desc = "Prev Hunk" })

    km.nmap("]H", function()
      gs.nav_hunk("last")
    end, { desc = "Last Hunk" })
    km.nmap("[H", function()
      gs.nav_hunk("first")
    end, { desc = "First Hunk" })

    km.nmap("<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
    km.xmap("<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
    km.nmap("<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
    km.xmap("<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
    -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")

    -- TODO: remap blame related lhs
    -- map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
    -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
    -- map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
    -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
    -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
    -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end,
}

return M
