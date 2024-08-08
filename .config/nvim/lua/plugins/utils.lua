return {
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
      }
    end,
    keys = {
      { "<leader>sl", ":SessionManager load_session<CR>", desc = "[S]ession [L]oad" },
    },
  },
  {
    "rcarriga/nvim-notify",
    keys = { { "<leader>n", require("notify").dismiss, desc = "Dismiss [N]otifications" } },
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true, -- Add a space b/w comment and the line
      sticky = true, -- Whether the cursor should stay at its position
      ignore = nil, -- Lines to be ignored while (un)comment
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = "<leader>cc", -- Line-comment toggle keymap
        block = "<leader>cb", -- Block-comment toggle keymap
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = "<leader>cc", -- Line-comment keymap
        block = "<leader>cb", -- Block-comment keymap
      },
      -- LHS of extra mappings
      extra = {
        above = "<leader>cO", -- Add comment on the line above
        below = "<leader>co", -- Add comment on the line below
        eol = "<leader>ca", -- Add comment at the end of line
      },
      mappings = {
        basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
      },
    },
    keys = {
      { "<leader>cc", mode = { "v", "n" } },
      { "<leader>cb", mode = { "v", "n" } },
      "<leader>co",
      "<leader>cO",
      "<leader>ca",
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },
  { "chrisgrieser/nvim-various-textobjs", opts = { useDefaultKeymaps = true } },
  {
    "kylechui/nvim-surround",
    version = "*",
    opts = function()
      return {
        surrounds = {
          -- GENERICS from https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-8593596
          g = {
            add = function()
              local config = require("nvim-surround.config")
              local result = config.get_input("Enter the generic name: ")
              if result then
                return { { result .. "<" }, { ">" } }
              end
            end,
            find = function()
              local config = require("nvim-surround.config")
              return config.get_selection({ node = "generic_type" })
            end,
            delete = "^(.-<)().-(>)()$",
            change = {
              target = "^(.-<)().-(>)()$",
              replacement = function()
                local config = require("nvim-surround.config")
                local result = config.get_input("Enter the generic name: ")
                if result then
                  return { { result .. "<" }, { ">" } }
                end
              end,
            },
          },
        },
      }
    end,
  },
  {
    "monaqa/dial.nvim",
    opts = function()
      local augend = require("dial.augend")
      local weekdays = augend.constant.new({
        elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
        word = true,
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      })
      return {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%d/%m/%Y"],
          augend.constant.alias.bool, -- boolean value (true <-> false)
          weekdays,
          months,
        },
      }
    end,
    config = function(_, opts)
      require("dial.config").augends:register_group(opts)
    end,
    keys = function()
      local dial = require("dial.map")
      return {
        { "<C-a>", dial.inc_normal() },
        { "<C-x>", dial.dec_normal() },
        { "<C-a>", dial.inc_visual(), mode = "v" },
        { "<C-x>", dial.dec_visual(), mode = "v" },
        { "g<C-a>", dial.inc_gvisual(), mode = "v" },
        { "g<C-x>", dial.dec_gvisual(), mode = "v" },
      }
    end,
  },
  "andymass/vim-matchup",
}
