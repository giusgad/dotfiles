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
local buffer_opts = { noremap = true, silent = true, buffer = true }

-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",
-- LEADER is mapped in init for lazyloading to work

-- remove stupid annoying thing
map({ "n", "v" }, "q:", "<nop>")

-- MOVEMENTS
-- center cursor when going down or up by half pages
map({ "v", "n" }, "<C-d>", "<C-d>zz")
map({ "v", "n" }, "<C-u>", "<C-u>zz")
-- center cursor when searching
map({ "v", "n" }, "n", "nzz")
map({ "v", "n" }, "N", "Nzz")
-- center marker after jump
-- vim.keymap.set("n", "'", "\"'\" . nr2char(getchar()) . 'zz'") TODO

-- OTHER
-- use sys clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"*y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"*p')
vim.keymap.set({ "n", "v" }, "<leader>d", '"*d')

-- INSERT MODE
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
	local function esc()
		if cmp.visible() then
			cmp.abort()
		end
		local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(key, "n", true)
	end

	vim.keymap.set("i", "<esc>", esc, opts)
end

-- VISUAL MODE
-- Copy
map("v", "<C-C>", ":w !xclip -i -sel c<CR><CR>gv") -- BUG: always copies the whole line
-- Maintain selection after indentation
map("v", ">", ">gv")
map("v", "<", "<gv")
-- Move text up and down
map("v", "<M-J>", ":m'>+1<CR>gv=gv")
map("v", "<M-K>", ":m-2<CR>gv=gv")
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
map("n", "<M-J>", "<Esc>:m .+1<CR>==V")
map("n", "<M-K>", "<Esc>:m .-2<CR>==V")
-- Open nvim tree
map("n", "<leader>e", ":NvimTreeToggle<cr>")
-- Buffers
map("n", "<leader>td", ":Bdelete<cr>")
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
-- LSPSAGA
local saga_ok, _ = pcall(require, "lspsaga")
if saga_ok then
	map("n", "<leader>vh", "<cmd>Lspsaga lsp_finder<CR>") -- view all options
	map({ "n", "v" }, "<leader>va", "<cmd>Lspsaga code_action<CR>") -- code action
	map("n", "<leader>vr", "<cmd>Lspsaga rename<CR>") -- rename
	map("n", "<leader>vd", "<cmd>Lspsaga peek_definition<CR>") -- definition in floating window
	map("n", "<leader>vl", "<cmd>Lspsaga show_line_diagnostics<CR>") -- show line diagnostics
	map("n", "<leader>vc", "<cmd>Lspsaga show_cursor_diagnostics<CR>") -- show cursor diagnostic
	map("n", "<leader>vo", "<cmd>Lspsaga outline<CR>") -- outline
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- hover docs
	map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>") -- jump to diagnostics
	map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>") -- jump to diagnostics
	vim.keymap.set("n", "[E", function() -- jump to errors
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	vim.keymap.set("n", "]E", function() -- jump to errors
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)
end
-- TROUBLE
local trouble_ok, _ = pcall(require, "trouble")
if trouble_ok then
	vim.keymap.set("n", "<leader>ve", require("trouble").toggle)
end
-- TELESCOPE
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
	vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
	vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
end
-- DAP
local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
local persist_bp_ok, persist_bp = pcall(require, "persistent-breakpoints.api")
if persist_bp_ok then
	vim.keymap.set("n", "<leader>db", persist_bp.toggle_breakpoint, opts)
	vim.keymap.set("n", "<leader>dB", persist_bp.set_conditional_breakpoint, opts)
	vim.keymap.set("n", "<leader>dR", persist_bp.clear_all_breakpoints, opts)
end
if dapui_ok then
	vim.keymap.set("n", "<leader>dd", dapui.toggle, opts)
end
if dap_ok then
	vim.keymap.set("n", "<leader>dc", dap.continue, opts)
	vim.keymap.set("n", "<leader>di", dap.step_into, opts)
	vim.keymap.set("n", "<leader>do", dap.step_over, opts)
	vim.keymap.set("n", "<leader>du", dap.step_out, opts)
end
-- dap-go

local dap_go_ok, dap_go = pcall(require, "dap-go")
if vim.fn.expand("%:e") == "go" and dap_go_ok then
	vim.keymap.set("n", "<leader>dt", dap_go.debug_test, buffer_opts)
	vim.keymap.set("n", "<leader>dT", dap_go.debug_test, buffer_opts)
end
-- UNDOTREE
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
-- TOGGLETERM
-- <M-d> to toggle
local term_ok, term = pcall(require, "toggleterm.terminal") -- terminal for lazygit
if term_ok then
	term = term.Terminal
	local lazygit = term:new({ cmd = "lazygit", direction = "float", hidden = true })
	local function _lazygit_toggle()
		lazygit:toggle()
	end

	vim.keymap.set({ "n", "t" }, "<leader>gg", _lazygit_toggle)

	for i = 1, 10, 1 do -- create separate terminals
		map("n", "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>")
	end
end
