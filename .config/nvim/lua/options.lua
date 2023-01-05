-- tabs/indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true

vim.opt.wrap = false
vim.opt.updatetime = 50

-- keep at least n extra lines visible while scrolling
vim.opt.scrolloff = 10

-- get undos from the past
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- to do case sensitve add \C

-- APPEARANCE
vim.opt.guifont = "Caskaydia Cove Nerd Font"
vim.opt.signcolumn = "yes" -- always show SignColumn
require("colors")
-- show line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
