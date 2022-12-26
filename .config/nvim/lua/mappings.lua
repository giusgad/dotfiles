-- FUNCTIONS
local function map(mode, shortcut, command)
	if type(mode) == "string" then
		vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
		return
	end
	for _, mod in ipairs(mode) do
		vim.api.nvim_set_keymap(mod, shortcut, command, { noremap = true, silent = true })
	end
end

local opts = { noremap = true, silent = true }

-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",

-- remove stupid annoying thing
map({ "n", "v" }, "q:", "<nop>")

-- LEADER (space)
vim.api.nvim_set_keymap("", "<space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- MOVEMENTS
-- center cursor when going down or up by half pages
map({ "v", "n" }, "<C-d>", "<C-d>zz")
map({ "v", "n" }, "<C-u>", "<C-u>zz")
-- center cursor when searching
map({ "v", "n" }, "n", "nzz")
map({ "v", "n" }, "N", "Nzz")
-- center marker after jump
-- vim.keymap.set("n", "'", "\"'\" . nr2char(getchar()) . 'zz'") TODO

-- VISUAL MODE
-- Copy
map("v", "<C-C>", ":w !xclip -i -sel c<CR><CR>gv")
-- Maintain selection after indentation
map("v", ">", ">gv")
map("v", "<", "<gv")
-- Move text up and down
map("v", "<M-j>", ":m'>+1<CR>gv=gv")
map("v", "<M-k>", ":m-2<CR>gv=gv")
-- Delete selected text on paste
map("v", "p", '"_dP')

-- NORMAL MODE
-- remove highlights with esc
map("n", "<esc>", ":noh<return><esc>")
-- cursor history
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")
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
map("n", "<M-j>", "<Esc>:m .+1<CR>==V")
map("n", "<M-k>", "<Esc>:m .-2<CR>==V")
-- Open nvim tree
map("n", "<leader>e", ":NvimTreeToggle<cr>")
-- Buffers
map("n", "<leader>td", ":Bdelete!<cr>")
map("n", "<leader>tn", ":tabnew<CR>")
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
-- LSP
map("n", "<leader>jD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz") -- TODO zz not working
map("n", "<leader>jd", "<cmd>lua vim.lsp.buf.definition()<CR>zz")
map("n", "<leader>f<space>", ":lua vim.lsp.buf.format()<CR>")
map("n", "<leader>vf", ":lua vim.lsp.buf.format()<CR>")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")

-- PLUGINS
-- lspsaga
map("n", "<leader>vh", "<cmd>Lspsaga lsp_finder<CR>") -- view all options
map({ "n", "v" }, "<leader>va", "<cmd>Lspsaga code_action<CR>") -- code action
map("n", "<leader>vr", "<cmd>Lspsaga rename<CR>") -- rename
map("n", "<leader>vd", "<cmd>Lspsaga peek_definition<CR>") -- definition in floating window
map("n", "<leader>vl", "<cmd>Lspsaga show_line_diagnostics<CR>") -- show line diagnostics
map("n", "<leader>vc", "<cmd>Lspsaga show_cursor_diagnostics<CR>") -- show cursor diagnostic
map("n", "<leader>vo", "<cmd>LSoutlineToggle<CR>") -- outline
map("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- hover docs
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>") -- jump to diagnostics
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>") -- jump to diagnostics
vim.keymap.set("n", "[E", function() -- jump to errors
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]E", function() -- jump to errors
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
-- dap
local dap = require("dap") -- TODO
local dapui = require("dapui")
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>dd", dapui.toggle, opts)
vim.keymap.set("n", "<leader>dc", dap.continue, opts)
vim.keymap.set("n", "<leader>di", dap.step_into, opts)
vim.keymap.set("n", "<leader>do", dap.step_over, opts)
vim.keymap.set("n", "<leader>du", dap.step_out, opts)
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- toggleterm
-- <M-d> to toggle
local term = require("toggleterm.terminal").Terminal -- terminal for lazygit
local lazygit = term:new({ cmd = "lazygit", direction = "float", hidden = true })
local function _lazygit_toggle()
	lazygit:toggle()
end

vim.keymap.set({ "n", "t" }, "<leader>gg", _lazygit_toggle)

for i = 1, 10, 1 do -- create separate terminals
	map("n", "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>")
end
