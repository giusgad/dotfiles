--PLUGINS
require("packer").startup(function()
	use("wbthomason/packer.nvim")
	-- THEME AND APPEARANCE
	use({ "ellisonleao/gruvbox.nvim" })
	use({
		"nvim-lualine/lualine.nvim", --lualine
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- devicons
	})

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
	})
	-- AUTOCOMPLETON
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- snippets engine - config inside cmp
	use({ "rafamadriz/friendly-snippets" }) -- snippets source
	use({
		"hrsh7th/cmp-nvim-lsp", -- lsp completions
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"hrsh7th/nvim-cmp", -- completion engine
		"saadparwaiz1/cmp_luasnip", -- snippet completions
	})
	use({ "glepnir/lspsaga.nvim" }) -- show definitions, code actions etc.
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- formatter/linter
end)

-- QUICK START
require("mason").setup()
require("mason-lspconfig").setup()

-- CONFIG
require("plugins.config")
