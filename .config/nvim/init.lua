-- USEFUL PATHS
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
-- CONFIG FILES
require("plugins")
require("mappings")
require("options")
