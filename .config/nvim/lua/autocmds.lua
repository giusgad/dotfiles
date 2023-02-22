-- indentation
--[[ vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.lua",
	callback = function()
        vim.bo.shiftwidth = 2
		vim.bo.expandtab = false
	end,
}) ]]

-- open help in vsplit
vim.api.nvim_create_autocmd({ "BufWinEnter", "Bufenter" }, {
	pattern = "*.txt",
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

-- check for changes when leaving terminal (for lazygit)
vim.api.nvim_create_autocmd("TermLeave", {
	callback = function()
		vim.cmd("e")
	end,
})
