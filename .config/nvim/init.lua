-- USEFUL PATHS
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
-- LEADER (space)
vim.api.nvim_set_keymap("", "<space>", "<Nop>", { noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- CONFIG FILES
require("plugins")
require("mappings")
require("options")
