return {
  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ThePrimeagen/git-worktree.nvim",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("git_worktree")
    end,
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>ff", builtin.find_files, desc = "telescope [F]ind [F]iles" },
        {
          "<leader>fF",
          function()
            builtin.find_files({ hidden = true, no_ignore = true })
          end,
          desc = "telescope [F]ind [F]iles",
        },
        { "<leader>fe", builtin.diagnostics, desc = "telescope diagnostics ([E]rrors)" },
        { "<leader>fm", builtin.marks, desc = "telescope [M]arks" },
        {
          "<leader>fE",
          function()
            builtin.diagnostics({ bufnr = 0 })
          end,
          desc = "telescope buffer diagnostics",
        },
        { "<leader>fg", builtin.live_grep, desc = "telescope [G]rep" },
        {
          "<leader>fb",
          builtin.buffers,
          desc = "telescope [B]uffers",
        },
        {
          "<leader>fn",
          ":Telescope notify<CR>",
          desc = "telescope [N]otifications",
        },
        { "<leader>ft", ":TodoTelescope<CR>", desc = "telescope [T]ODOs" },
        {
          "<leader>fs",
          builtin.lsp_dynamic_workspace_symbols,
          desc = "telescope LSP [S]ymbols",
        },
        -- git
        {
          "<leader>gtl",
          require("telescope").extensions.git_worktree.git_worktrees,
          desc = "git work[T]ree [L]ist/switch",
        },
        {
          "<leader>gtn",
          require("telescope").extensions.git_worktree.create_git_worktree,
          desc = "git work[T]ree add/[N]ew",
        },
        {
          "<leader>gs",
          builtin.git_status,
          desc = "telescope [G]it [S]tatus",
        },
      }
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
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Open [U]ndo tree" },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = function()
      return {
        { "<leader>o", require("oil").toggle_float, desc = "Toggle [O]il" },
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    keys = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      return {
        -- stylua: ignore start
        { "<leader>a", mark.add_file,                 desc = "add to Harpoon" },
        { "<C-f>",     ui.toggle_quick_menu,          desc = "Harpoon show files" },
        { "<leader>h", function() ui.nav_file(1) end, desc = "Harpoon jump" },
        { "<leader>j", function() ui.nav_file(2) end, desc = "Harpoon jump" },
        { "<leader>k", function() ui.nav_file(3) end, desc = "Harpoon jump" },
        { "<leader>l", function() ui.nav_file(4) end, desc = "Harpoon jump" }
,
        -- stylua: ignore end
      }
    end,
  },
}
