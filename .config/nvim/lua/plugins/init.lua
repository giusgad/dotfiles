-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
	-- DEV
	{
		"folke/neodev.nvim",
		config = true,
		opts = {
			override = function(_, options)
				options.library.enabled = true
			end,
		},
	},
	{
		"giusgad/pets.nvim",
		dependencies = { "MunifTanjim/nui.nvim", { "giusgad/hologram.nvim", dev = false } },
		lazy = false,
		dev = false,
	},

	-- UTILITY
	"numToStr/Comment.nvim", -- comment lines and blocks
	"windwp/nvim-autopairs", -- close brackets automatically
	"akinsho/toggleterm.nvim",
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
		opts = function()
			vim.o.termguicolors = true
			require("colorizer").setup()
		end,
	},
	{
		"folke/noice.nvim", -- cmdline popup and cool things
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{ "chrisgrieser/nvim-various-textobjs", opts = { useDefaultKeymaps = true }, config = true },
	{ "kylechui/nvim-surround", version = "*", config = true },
	{
		"folke/which-key.nvim",
		config = true,
		opts = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup()
		end,
	},
	"christoomey/vim-tmux-navigator",
	"monaqa/dial.nvim",

	-- MINIGAMES
	"ThePrimeagen/vim-be-good",
	"eandrju/cellular-automaton.nvim",

	-- THEME AND APPEARANCE
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 }, -- gruvbox theme
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
		},
		config = true,
	}, -- show indentation guides

	-- SYNTAX HIGHLIGHTING
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- more syntax highlighting
	"nvim-treesitter/playground", -- tools
	"RRethy/vim-illuminate",
	"mrjones2014/nvim-ts-rainbow",

	-- LUALINE
	{
		"nvim-lualine/lualine.nvim", --lualine
		-- dependencies = { "kyazdani42/nvim-web-devicons", opt = true }, -- devicons
		lazy = false,
		priority = 900,
	},

	-- SESSION-MANAGER
	"Shatur/neovim-session-manager",

	-- MARKDOWN
	{
		"epwalsh/obsidian.nvim",
		config = true,
		opts = { dir = "~/Documents/obsidian/vault/", completion = { nvim_cmp = true }, disable_frontmatter = true },
		ft = "markdown",
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = "markdown",
	},

	-- NERD TREE
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", config = true }, -- optional, for file icons
		},
	},

	-- UNDO TREE
	"mbbill/undotree",

	-- BUFFERS
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	"famiu/bufdelete.nvim",

	-- GIT
	"lewis6991/gitsigns.nvim",

	-- TELESCOPE
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0", -- popup menu
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"nvim-telescope/telescope-ui-select.nvim", -- input selector

	-- LSP
	"williamboman/mason.nvim", -- lsp installer
	"williamboman/mason-lspconfig.nvim", -- adapter for configuration
	"neovim/nvim-lspconfig", -- configure lsp
	"jayp0521/mason-null-ls.nvim", -- null-ls to mason integration
	-- yuck
	"elkowar/yuck.vim",

	-- DEBUGGING
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"jayp0521/mason-nvim-dap.nvim",
	"Weissle/persistent-breakpoints.nvim", -- persist breakpoints
	"leoluz/nvim-dap-go", -- go debugging with delve

	-- AUTOCOMPLETON and DIAGNOSTICS
	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } }, -- snippets engine - config inside cmp
	-- "rafamadriz/friendly-snippets", -- snippets source
	"hrsh7th/cmp-nvim-lsp", -- lsp completions
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/nvim-cmp", -- completion engine
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	{ "glepnir/lspsaga.nvim", event = "BufRead" }, -- show definitions, code actions etc.

	-- NULL-LS
	"jose-elias-alvarez/null-ls.nvim", -- formatter/linter
	--[[ {
		"ThePrimeagen/refactoring.nvim", -- refactoring for go/python/js
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}, ]]

	-- TROUBLE
	{
		"folke/trouble.nvim",
		-- dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
	},

	-- TODO COMMENTS
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},

	-- LEAP
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{ "ggandor/flit.nvim", config = true },
}, {
	dev = { path = "/home/giuseppe/coding/lua/plugins/" },
})

-- CONFIG
require("plugins.config")

-- QUICK SETUP
require("illuminate").configure({
	min_count_to_highlight = 2,
})
require("gitsigns").setup({
	worktrees = {
		{
			toplevel = vim.env.HOME,
			gitdir = vim.env.HOME .. "/.dotfiles/",
		},
	},
})

require("session_manager").setup({
	autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
})

-- vim.api.nvim_set_hl(0, "pets_popup", { link = "Normal" })
require("pets").setup({
	row = 6,
	default_pet = "slime",
	default_style = "green",
	random = true,
	popup = {
		-- winblend = 10,
	},
})
-- require("hologram").setup({ auto_display = true })
