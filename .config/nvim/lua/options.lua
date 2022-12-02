-- show line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs/indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true

-- APPEARANCE
vim.opt.guifont = "Caskaydia Cove Nerd Font"
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
-- sign column and sign
vim.api.nvim_set_hl(0, "SignColumn", {})
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#fb4934" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#fabd2d" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#689d6a" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#83a598" })
-- bufferline underline between tabs
vim.api.nvim_set_hl(0, "BufferlineIndicatorSelected", {})
