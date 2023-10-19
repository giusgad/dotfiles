-- indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.scss", "*.css", "*.ts*", "*.js*", "*.json", "*.java" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.expandtab = false
    end,
})
-- open help in vsplit
vim.api.nvim_create_autocmd({ "BufWinEnter", "Bufenter" }, {
    callback = function()
        if vim.bo.filetype == "help" or vim.bo.filetype == "fugitive" then
            vim.cmd.wincmd("L")
        end
    end,
})

-- check for changes when leaving terminal (for lazygit)
vim.api.nvim_create_autocmd("TermLeave", {
    callback = function()
        if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
            vim.cmd("e")
        end
    end,
})
