local lualine_c = { "filename" }
local ok, noice = pcall(require, "noice")
if ok then
	lualine_c = { -- show macro recording
		"filename",
		{
			noice.api.statusline.mode.get,
			cond = noice.api.statusline.mode.has,
			color = { fg = "#ff9e64" },
		},
	}
end

local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "", right = "" } } },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = lualine_c,
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = { { "location", separator = { left = "", right = "" } } },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
