return {
  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ThePrimeagen/git-worktree.nvim",
    },
    opts = {},
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("git_worktree")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<M-d>",
      shell = "/usr/bin/fish",
      size = 15,
      direction = "tab",
      float_opts = {
        border = "curved",
      },
      highlights = {
        FloatBorder = {
          Normal = { link = "Normal" },
          NormalFloat = { link = "Normal" },
          guifg = "#d79921",
        },
      },
      shade_terminals = false,
      -- shading_factor = 100,
    },
    keys = function()
      local keys = { "<M-d>" }
      for i = 1, 10, 1 do -- create separate terminals
        table.insert(keys, { "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>", desc = "open new term with id:" .. i })
      end
      return keys
    end,
  },
  {
    "mbbill/undotree",
    init = function()
      vim.g.undotree_WindowLayout = 2
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "ThePrimeagen/harpoon",
}
