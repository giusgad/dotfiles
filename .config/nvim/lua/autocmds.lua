-- indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.scss", "*.css", "*.less", "*.ts*", "*.*js*", "*.json", "*.java", "*.c", "*.sql", "*.lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
-- open help in vsplit
vim.api.nvim_create_autocmd({ "BufWinEnter", "Bufenter" }, {
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})

vim.filetype.add({ extension = { wgsl = "wgsl", ampl = "ampl", ejs = "html" } })
-- indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.mod",
  callback = function()
    vim.bo.filetype = "ampl"
  end,
})
