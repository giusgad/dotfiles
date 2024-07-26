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
    keys = { "<leader>cc", "<leader>cb", "<leader>co", "<leader>cO", "<leader>ca" },
  },
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
  { "chrisgrieser/nvim-various-textobjs", opts = { useDefaultKeymaps = true } },
  { "kylechui/nvim-surround", version = "*", config = true },
  {
    "monaqa/dial.nvim",
    opts = function()
      local augend = require("dial.augend")
      return {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
        },
      }
    end,
    config = function(_, opts)
      require("dial.config").augends:register_group(opts)
    end,
  },
  "andymass/vim-matchup",
}
