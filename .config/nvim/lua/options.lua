-- tabs/indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false
vim.opt.updatetime = 50
vim.opt.autoread = true

vim.opt.scrolloff = 10 -- keep at least n extra lines visible while scrolling
vim.opt.mouse = "" -- disable mouse

-- get undos from the past
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- to do case sensitve add \C

-- spellchecking
vim.opt.spell = true
vim.opt.spelllang = "en_us,it"

-- APPEARANCE
-- vim.opt.guifont = "Caskaydia Cove Nerd Font" -- set by terminal
vim.opt.signcolumn = "yes" -- always show SignColumn
vim.opt.laststatus = 3
require("colors")
-- show line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmode = false
