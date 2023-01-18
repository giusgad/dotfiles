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
	{ "folke/neodev.nvim", config = true },
	{ dir = "/mnt/shared/coding/lua/plugins/pets.nvim", lazy = false },

	-- UTILITY
	"numToStr/Comment.nvim", -- comment lines and blocks
	"windwp/nvim-autopairs", -- close brackets automatically
	"akinsho/toggleterm.nvim",
	{
		"folke/noice.nvim", -- cmdline popup and cool things
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	"christoomey/vim-tmux-navigator",
	{ "chrisgrieser/nvim-various-textobjs", config = { useDefaultKeymaps = true } },
	{ "kylechui/nvim-surround", version = "*", config = true },
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup()
		end,
	},

	-- MINIGAMES
	"ThePrimeagen/vim-be-good",
	"eandrju/cellular-automaton.nvim",

	-- THEME AND APPEARANCE
	{ "ellisonleao/gruvbox.nvim", priority = 1000 }, -- gruvbox theme
	{
		"lukas-reineke/indent-blankline.nvim",
		config = {
			space_char_blankline = " ",
			show_current_context = true,
		},
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
	},

	-- SESSION-MANAGER
	"Shatur/neovim-session-manager",

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
	{ "akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons" },
	"famiu/bufdelete.nvim",

	-- GITSIGNS
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
})

-- QUICK SETUP
require("illuminate").configure({
	min_count_to_highlight = 2,
})
require("gitsigns").setup()

-- CONFIG
require("plugins.config")
