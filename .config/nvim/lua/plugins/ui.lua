return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  { "stevearc/dressing.nvim", config = true, event = "VeryLazy" },
  {
    "nvim-lualine/lualine.nvim", --lualine
    event = "VeryLazy",
    opts = function()
      local has_noice, noice = pcall(require, "noice")
      if has_noice then
        lualine_c = { -- show macro recording
          {
            noice.api.statusline.mode.get,
            cond = noice.api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        }
      end
      local custom_gruvbox = require("lualine.themes.gruvbox")
      custom_gruvbox.normal.c.bg = nil
      custom_gruvbox.insert.c.bg = nil
      custom_gruvbox.visual.c.bg = nil
      custom_gruvbox.replace.c.bg = nil
      custom_gruvbox.command.c.bg = nil
      custom_gruvbox.inactive.c.bg = nil

      return {
        options = {
          icons_enabled = true,
          globalstatus = true, -- show only one statusline in splits needs laststatus=3
          theme = custom_gruvbox,
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "", right = "" } } },
          lualine_b = { "filename", "branch", "diff", "diagnostics" },
          lualine_c = lualine_c,
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = { { "location", separator = { left = "", right = "" } } },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" }) -- fix for https://github.com/nvim-lualine/lualine.nvim/issues/867
    end,
  },
  {
    "folke/noice.nvim", -- cmdline popup and cool things
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        -- progress = { enabled = false },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    branch = "master",
    opts = {
      debounce = 100,
      scope = {
        show_start = false,
        show_end = false,
        include = {
          node_type = { rust = { "use_list", "field_initializer_list" }, lua = { "table_constructor" } },
        },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "IblScope", { link = "GruvboxYellow" })
    end,
  }, -- show indentation guides
  {
    "folke/which-key.nvim",
    opts = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      return { icons = { mappings = false } }
    end,
  },
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", { "giusgad/hologram.nvim", dev = false } },
    cmd = { "PetsNew", "PetsNewCustom" },
    opts = {
      row = 7,
      default_pet = "slime",
      default_style = "green",
      random = true,
      popup = {
        -- winblend = 10,
      },
    },
    dev = false,
  },
}
