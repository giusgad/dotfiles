return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    opts = { graph_style = "unicode" },
    keys = function()
      local neogit = require("neogit")
      return {
        { "<leader>gg", neogit.open, desc = "Open neo[G]it" },
        {
          "<leader>gl",
          function()
            neogit.open({ "log" })
          end,
          desc = "Open [G]it [Log]",
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      worktrees = {
        {
          toplevel = vim.env.HOME,
          gitdir = vim.env.HOME .. "/.dotfiles/",
        },
      },
    },
    keys = function()
      local gs = require("gitsigns")
      return {
        { "<leader>gp", gs.preview_hunk, desc = "git [P]review hunk" },
        { "<leader>gd", gs.diffthis, desc = "git [D]iff" },
        {
          "<leader>gD",
          function()
            local branch = vim.fn.input({ prompt = "branch to diff against:", default = "main", cancelreturn = "main" })
            gs.diffthis(branch)
          end,
          desc = "git [D]iff on custom branch",
        },
        { "<leader>gr", gs.reset_hunk, desc = "git [R]eset hunk" },
        { "<leader>gR", gs.reset_buffer, desc = "git [R]eset buffer" },
        { "<leader>gh", gs.stage_hunk, desc = "git stage [H]unk" },
        { "<leader>gS", gs.stage_buffer, desc = "git [S]tage buffer" },
        { "<leader>gv", gs.toggle_deleted, desc = "git [V]iew deleted" },
        { "<leader>gb", gs.blame_line, desc = "git [B]lame line" },
        { "<leader>gB", gs.blame, desc = "git [B]lame file" },
        { "[h", gs.prev_hunk, desc = "git prev hunk" },
        { "]h", gs.next_hunk, desc = "git next hunk" },
      }
    end,
  },
}
