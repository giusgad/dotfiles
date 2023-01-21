local lualine_c = {}
local ok, noice = pcall(require, "noice")
if ok then
	lualine_c = { -- show macro recording
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

local custom_gruvbox = require("lualine.themes.gruvbox")

-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
custom_gruvbox.insert.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
custom_gruvbox.visual.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
custom_gruvbox.replace.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
custom_gruvbox.command.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")
custom_gruvbox.inactive.c.bg = require("lualine.utils.utils").extract_highlight_colors("Normal", "bg")

lualine.setup({
	options = {
		icons_enabled = true,
		globalstatus = true, -- show only one statusline in splits needs laststatus=3
		theme = custom_gruvbox,
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "", right = "" } } },
		lualine_b = { "filename", "branch", "diff", "diagnostics" },
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
