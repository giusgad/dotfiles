local bufferline = require("bufferline")
bufferline.setup({
	options = {
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator = { style = "underline", icon = "" }, -- underline style is based on terminal
		buffer_close_icon = "",
		-- buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		-- close_icon = '',
		left_trunc_marker = "",
		right_trunc_marker = "",

		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,

		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		show_buffer_icons = false,
		-- color_icons = false,
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = false,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- see :h bufferline-styling
		separator_style = { "", "" }, -- | "thick" | "thin" | { 'left', 'right' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},
	highlights = {
		background = {
			fg = "#ebdbb2",
		},
		close_button = {
			fg = "#ebdbb2",
		},
		close_button_selected = {
			fg = "#d79921",
		},
		close_button_visible = {
			fg = "#d79921",
		},
		buffer_selected = {
			fg = "#d79921",
		},
		buffer_visible = {
			fg = "#d79921",
		},
		modified = {
			fg = "#ebdbb2",
		},
		modified_selected = {
			fg = "#d79921",
		},
	},
})

-- HIGHLIGHTING FIX
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#d79921", sp = "#d79921", underline = true })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#d79921", sp = "#d79921", underline = true })
