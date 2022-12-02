vim.api.nvim_set_keymap("n", "<leader>f<space>", ":lua vim.lsp.buf.format()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", { silent = true })
