local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then
	return
end
toggleterm.setup({
	open_mapping = "<M-d>",
	shell = "/usr/bin/fish",
	size = 15,
	direction = "float",
	float_opts = {
		border = "curved",
	},
	highlights = {
		FloatBorder = {
			Normal = { link = "Normal" },
			NormalFloat = { link = "Normal" },
			guifg = "#d79921",
		},
	},
	shade_terminals = false,
	-- shading_factor = 100,
})
