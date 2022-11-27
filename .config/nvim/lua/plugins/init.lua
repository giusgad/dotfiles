--PLUGINS
require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- THEME AND APPEARANCE
    use({ "ellisonleao/gruvbox.nvim" }) -- gruvbox theme
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- more syntax highlighting
    use({
        "nvim-lualine/lualine.nvim", --lualine
        requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- devicons
    })

    -- BUFFERLINE
    use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

    -- DASHBOARD
    use({ "glepnir/dashboard-nvim" })

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
    })
    -- AUTOCOMPLETON and DIAGNOSTICS
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

    -- UTILITY
    use({ "numToStr/Comment.nvim" }) -- comment with <gcc>
    use({ "windwp/nvim-autopairs" }) -- close brackets automatically
end)

-- CONFIG
require("plugins.config")

-- QUICK SETUP
require("Comment").setup()
