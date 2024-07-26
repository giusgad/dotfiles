local plugins = {
  -- DEV
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", { "giusgad/hologram.nvim", dev = false } },
    lazy = false,
    dev = false,
  },

  -- UTILITY
  { "chrisgrieser/nvim-various-textobjs", opts = { useDefaultKeymaps = true }, config = true },
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
  { "stevearc/dressing.nvim", config = true },

  -- THEME AND APPEARANCE
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- SYNTAX HIGHLIGHTING

  -- LUALINE

  -- SESSION-MANAGER

  -- UNDO TREE
  {
    "mbbill/undotree",
    init = function()
      vim.g.undotree_WindowLayout = 2
    end,
  },

  -- GIT

  -- TELESCOPE

  -- LSP

  -- DEBUGGING

  -- AUTOCOMPLETON and DIAGNOSTICS

  -- NULL-LS

  -- TODO COMMENTS
}

--[[
vim.g.undotree_WindowLayout = 2

-- QUICK SETUP
require("illuminate").configure({
	min_count_to_highlight = 2,
})
require("gitsigns").setup()

require("session_manager").setup({
	autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
})

-- vim.api.nvim_set_hl(0, "pets_popup", { link = "Normal" })
require("pets").setup({
	row = 7,
	default_pet = "slime",
	default_style = "green",
	random = true,
	popup = {
		-- winblend = 10,
	},
})

-- markdown preview
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/markdown.css")

vim.g.rustaceanvim = {
	server = {
		on_attach = require("plugins.config.handlers").on_attach,
		settings = {
			-- rust-analyzer language server configuratio
			["rust-analyzer"] = require("plugins.config.lsp.settings.rust-analyzer"),
		},
	},
}
]]

return plugins
