return {
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
      for i = 1, 9, 1 do -- create separate terminals
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
        { "<leader>l", function() ui.nav_file(4) end, desc = "Harpoon jump" },
        { "<leader>;", function() ui.nav_file(5) end, desc = "Harpoon jump" },
        -- stylua: ignore end
      }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { { "junegunn/fzf", build = "fzf#install" } },
    ft = "qf",
    config = true,
  },
}
