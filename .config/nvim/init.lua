-- USEFUL PATHS
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
-- CONFIG FILES
require("mappings")
require("plugins")
require("options")
