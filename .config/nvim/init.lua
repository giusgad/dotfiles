-- USEFUL PATHS
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
-- impatient
require("impatient")
-- CONFIG FILES
require("mappings")
require("plugins")
require("options")
