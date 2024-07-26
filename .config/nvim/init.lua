-- USEFUL PATHS
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
-- LEADER (space)
vim.api.nvim_set_keymap("", "<space>", "<Nop>", { noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- CONFIG FILES
-- Plugins
require("lazy").setup({ { import = "plugins" } }, {
	dev = { path = "/home/giuseppe/coding/lua/plugins/" },
})
require("mappings")
require("options")
require("autocmds")
