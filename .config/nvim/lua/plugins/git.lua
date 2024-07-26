return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = true,
    opts = { graph_style = "unicode" },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      worktrees = {
        {
          toplevel = vim.env.HOME,
          gitdir = vim.env.HOME .. "/.dotfiles/",
        },
      },
    },
  },
}
