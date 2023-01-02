--PLUGINS
require("packer").startup(function()
	use("wbthomason/packer.nvim")

	--MINIGAME
	use("ThePrimeagen/vim-be-good")

	-- IMPATIENT
	use("lewis6991/impatient.nvim")

	-- THEME AND APPEARANCE
	use("ellisonleao/gruvbox.nvim") -- gruvbox theme

	-- SYNTAX HIGHLIGHTING
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- more syntax highlighting
	-- use("nvim-treesitter/playground") -- tools
	use("RRethy/vim-illuminate")

	-- LUALINE
	use({
		"nvim-lualine/lualine.nvim", --lualine
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- devicons
	})

	-- NERD TREE
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})
	use("nvim-tree/nvim-web-devicons")

	-- UNDO TREE
	use("mbbill/undotree")

	-- BUFFERS
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use("famiu/bufdelete.nvim")

	-- GITSIGNS
	use("lewis6991/gitsigns.nvim")

	-- DASHBOARD
	use("glepnir/dashboard-nvim")

	-- TELESCOPE
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0", -- popup menu
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- LSP
	use({
		"williamboman/mason.nvim", -- lsp installer
		"williamboman/mason-lspconfig.nvim", -- adapter for configuration
		"neovim/nvim-lspconfig", -- configure lsp
		"jayp0521/mason-null-ls.nvim", -- null-ls to mason integration
	})

	-- DEBUGGING
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("jayp0521/mason-nvim-dap.nvim")
	use({ "Weissle/persistent-breakpoints.nvim" }) -- persist breakpoints
	use("leoluz/nvim-dap-go") -- go debugging with delve

	-- AUTOCOMPLETON and DIAGNOSTICS
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- snippets engine - config inside cmp
	use("rafamadriz/friendly-snippets") -- snippets source
	use({
		"hrsh7th/cmp-nvim-lsp", -- lsp completions
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"hrsh7th/nvim-cmp", -- completion engine
		"saadparwaiz1/cmp_luasnip", -- snippet completions
	})
	use("glepnir/lspsaga.nvim") -- show definitions, code actions etc.

	-- NULL-LS
	use("jose-elias-alvarez/null-ls.nvim") -- formatter/linter
	use({
		-- "ThePrimeagen/refactoring.nvim", -- refactoring for go/python/js
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- TROUBLE
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})
	-- TODO COMMENTS
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	-- UTILITY
	use("numToStr/Comment.nvim") -- comment with <gcc>
	use("windwp/nvim-autopairs") -- close brackets automatically
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	use({
		"folke/noice.nvim",
		requires = { -- cmdline popup and cool things
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})
	use("christoomey/vim-tmux-navigator")
end)

-- QUICK SETUP
-- require("refactoring").setup()
require("nvim-web-devicons").setup()
require("gitsigns").setup()
require("illuminate").configure({
	min_count_to_highlight = 2,
})
require("todo-comments").setup()

-- CONFIG
require("plugins.config")
