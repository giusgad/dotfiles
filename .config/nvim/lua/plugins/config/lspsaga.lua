local saga_ok, saga = pcall(require, "lspsaga")
if not saga_ok then
	return
end

saga.setup({
	ui = {
		theme = "round",
		border = "rounded", -- can be single,double,rounded,solid,shadow
		title = true,
		winblend = 0,
		code_action = "",
		colors = {
			--float window normal background color
			normal_bg = "",
			--title background color
			title_bg = "",
			red = "#fb4934",
			magenta = "#d3829b",
			orange = "#fe8019",
			yellow = "#fabd2f",
			green = "#b8bb26",
			cyan = "#8ec07c",
			blue = "#83a598",
			purple = "#d3829b",
			white = "#ebdbb2",
			black = "#282828",
		},
	},
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	request_timeout = 2000,
	finder = {
		edit = { "o", "<cr>" },
		vsplit = "s",
		split = "i",
		tabe = "t",
		quit = { "q", "<esc>" },
	},
	definition = {
		edit = "<c-c>o",
		vsplit = "<c-c>v",
		split = "<c-c>i",
		tabe = "<c-c>t",
		quit = "<esc>",
	},
	code_action = {
		keys = {
			quit = "<esc>",
			exec = "<cr>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		-- update_time = 150,
		sign_priority = 40,
		virtual_text = false, -- show icon at the end of the line
	},
	diagnostic = { -- jump to diagnostic options
		jump_num_shortcut = true,
		show_code_action = true,
		show_source = true,
		keys = {
			exec_action = "o",
			quit = "<esc>",
			go_action = "g",
		},
	},
	rename = {
		quit = "<C-c>",
		exec = "<cr>",
		in_select = true,
	},
	outline = {
		win_position = "right",
		win_with = "",
		win_width = 30,
		auto_close = false,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		custom_sort = nil,
		keys = {
			jump = "o",
			expand_collapse = "u",
			quit = { "q", "<esc>" },
		},
		-- virt_text = "┃",
		-- jump_key = "o",
		-- -- auto refresh when change buffer
		-- in_position = "right",
	},
	-- callhierarchy = {},
	symbol_in_winbar = { -- top outline
		enable = true,
		separator = " ",
		show_file = true,
		hide_keyword = true,
		folder_level = 2,
		respect_root = false,
	},
})
