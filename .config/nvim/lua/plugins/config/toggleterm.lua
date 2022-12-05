require("toggleterm").setup({
	open_mapping = "<M-d>",
	shell = "/usr/bin/fish",
	size = 15,
	direction = "float",
	float_opts = {
		border = "curved",
		winblend = 5,
	},
	highlights = {
		FloatBorder = {
			guifg = "#d79921",
		},
	},
	-- shade_terminals = false,
	-- shading_factor = 100,
})
