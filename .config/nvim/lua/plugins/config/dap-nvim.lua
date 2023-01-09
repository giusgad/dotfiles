-- require("dap").defaults.fallback.terminal_win_cmd = ""

require("dapui").setup()
require("dap-go").setup({
	dap_configurations = { -- support for headless mode
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
})
vim.api.nvim_create_autocmd("FileType", { -- hide repl buffer
	pattern = "dap-repl",
	callback = function(args)
		vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
	end,
})
require("persistent-breakpoints").setup({
	save_dir = vim.fn.stdpath("data") .. "/nvim_breakpoints",
	-- save_dir = os.getenv("HOME") .. "/.config/nvim/undodir",
	-- when to load the breakpoints? "BufReadPost" is recommanded.
	load_breakpoints_event = "BufReadPost",
	-- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
	perf_record = false,
})

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#fb4934" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapStopped", { text = "" })
