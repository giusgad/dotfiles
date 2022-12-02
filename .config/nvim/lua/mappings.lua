-- FUNCTIONS
local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",

-- LEADER (space)
vim.api.nvim_set_keymap("", "<space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- VISUAL MODE
-- Copy
map("v", "<C-C>", ":w !xclip -i -sel c<CR><CR>gv")
-- Maintain selection after indentation
map("v", ">", ">gv")
map("v", "<", "<gv")
-- Move text up and down
map("v", "<M-j>", ":m'>+1<CR>gv")
map("v", "<M-k>", ":m-2<CR>gv")
-- Delete selected text on paste
map("v", "p", '"_dP')

-- NORMAL MODE
-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")
-- Move text up and down
map("n", "<M-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<M-k>", "<Esc>:m .-2<CR>==gi")
-- Open nvim tree
map("n", "<leader>e", ":NvimTreeToggle<cr>")
-- Buffers
map("n", "gt", ":Bdelete!<cr>")
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- IMPORT plugin mappings
require("plugins.config.telescope.mappings")
require("plugins.config.null-ls.mappings")
require("plugins.config.lspsaga.mappings")
