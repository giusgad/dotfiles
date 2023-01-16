local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
	return
end

configs.setup({
	ensure_installed = { "" }, -- A list of parser names, or "all"
	sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
	auto_install = false, -- set to false if tree-sitter cli not installed
	ignore_install = { "" }, -- List of parsers to ignore installing (for "all")

	autopairs = { enable = true },
	highlight = {
		enable = true, -- `false` will disable the whole extension
		disable = { "all" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		termcolors = { "Yellow", "Green", "Cyan", "Magenta", "Blue" }, -- table of colour name strings
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_decremental = "<S-CR>",
			node_decremental = "<BS>",
		},
	},
})

vim.api.nvim_set_hl(0, "rainbowcol1", { ctermfg = "White" })
