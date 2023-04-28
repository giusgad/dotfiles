-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",
-- LEADER is mapped in init for lazyloading to work
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

-- remove stupid annoying thing
map({ "n", "v" }, "q:", "<nop>")
-- remap <C-w> for buffers
map("n", "<C-q>", "<C-w>")

-- TERM
vim.keymap.set("t", "<C-esc>", "<C-\\><C-n>", opts)

-- MOVEMENTS
-- center cursor when going down or up by half pages
map({ "v", "n" }, "<C-d>", "<C-d>zz")
map({ "v", "n" }, "<C-u>", "<C-u>zz")
-- center cursor when searching
map({ "v", "n" }, "n", "nzz")
map({ "v", "n" }, "N", "Nzz")
-- center marker after jump
-- vim.keymap.set("n", "'", "\"'\" . nr2char(getchar()) . 'zz'") TODO
map({ "v", "n" }, "0", "^")
map({ "v", "n" }, "^", "0")
map({ "v", "n" }, "<C-%>", "$%")

-- OTHER
-- use sys clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", 'o<esc>"+p')
-- delete to nil register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
-- add undo points while typing
map("i", "<Space>", "<C-g>u<Space>")
-- map("i", "<CR>", "<C-g>u<CR>") -- breaks autopairs
map("i", ",", "<C-g>u,")
map("i", ".", "<C-g>u.")
map("i", "(", "<C-g>u(")
map("i", "[", "<C-g>u[")
map("i", "{", "<C-g>u{")

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
-- Window navigation - now integrated with tmux navigator
--[[ map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l") ]]
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
map("n", "<C-w>", ":Bdelete<cr>")
map("n", "<leader>tn", ":tabnew<CR>")
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<C-Tab>", ":bnext<CR>")
map("n", "<C-S-Tab>", ":bprevious<CR>")
-- LSP
map("n", "<leader>jD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz") -- TODO: zz not working
map("n", "<leader>jd", "<cmd>lua vim.lsp.buf.definition()<CR>zz")
map("n", "<leader>f<space>", ":lua vim.lsp.buf.format()<CR>")
map("n", "<leader>vf", ":lua vim.lsp.buf.format()<CR>")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>")

-- PLUGINS
-- NOTIFY
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
	vim.keymap.set({ "n", "v" }, "<leader>h", notify.dismiss)
end
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

-- GITSIGNS
local gs_ok, gs = pcall(require, "gitsigns")
if gs_ok then
	vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts)
	vim.keymap.set("n", "<leader>gb", function()
		gs.blame_line({ full = true })
	end, opts)
	vim.keymap.set("n", "<leader>gl", gs.toggle_current_line_blame, opts)
	vim.keymap.set("n", "<leader>gd", gs.diffthis, opts)
	vim.keymap.set("n", "<leader>gD", function()
		gs.diffthis("~")
	end, opts)
	vim.keymap.set("n", "<leader>gr", gs.toggle_deleted, opts)
end
-- TROUBLE
local trouble_ok, _ = pcall(require, "trouble")
if trouble_ok then
	vim.keymap.set("n", "<leader>vt", require("trouble").toggle)
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
	vim.keymap.set("n", "<leader>bb", persist_bp.toggle_breakpoint, opts)
	vim.keymap.set("n", "<leader>bB", persist_bp.set_conditional_breakpoint, opts)
	vim.keymap.set("n", "<leader>bR", persist_bp.clear_all_breakpoints, opts)
end
if dapui_ok then
	vim.keymap.set("n", "<leader>bv", dapui.toggle, opts)
end
if dap_ok then
	vim.keymap.set("n", "<leader>bc", dap.continue, opts)
	vim.keymap.set("n", "<leader>bi", dap.step_into, opts)
	vim.keymap.set("n", "<leader>bo", dap.step_over, opts)
	vim.keymap.set("n", "<leader>bu", dap.step_out, opts)
end
-- dap-go
local dap_go_ok, dap_go = pcall(require, "dap-go")
if vim.fn.expand("%:e") == "go" and dap_go_ok then
	vim.keymap.set("n", "<leader>bt", dap_go.debug_test, buffer_opts)
	vim.keymap.set("n", "<leader>bT", dap_go.debug_test, buffer_opts)
end

-- UNDOTREE
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- TOGGLETERM
-- <M-d> to toggle
local term_ok, term = pcall(require, "toggleterm.terminal") -- terminal for lazygit
if term_ok then
	term = term.Terminal
	-- lazygit terminal
	local lazygit = term:new({ cmd = "lazygit", direction = "float", hidden = true })
	local function _lazygit_toggle()
		lazygit:toggle()
	end

	vim.keymap.set("n", "<leader>gg", _lazygit_toggle)
	vim.keymap.set("t", "<M-k>", _lazygit_toggle)

	-- numbered terminals
	for i = 1, 10, 1 do -- create separate terminals
		map("n", "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>")
	end
end

-- SESSION MANAGER
map("n", "<leader>sl", ":SessionManager load_session<CR>")

-- BUFFERLINE
local bufferline_ok = pcall(require, "bufferline")
if bufferline_ok then
	map("n", "<S-h>", ":BufferLineCyclePrev<CR>")
	map("n", "<S-l>", ":BufferLineCycleNext<CR>")
	map("n", "<leader>th", ":BufferLineMovePrev<CR>")
	map("n", "<leader>tl", ":BufferLineMoveNext<CR>")
end

-- DIAL
local dial_ok, dial = pcall(require, "dial.map")
if dial_ok then
	vim.keymap.set("n", "<C-a>", dial.inc_normal(), opts)
	vim.keymap.set("n", "<C-x>", dial.dec_normal(), opts)
	vim.keymap.set("v", "<C-a>", dial.inc_visual(), opts)
	vim.keymap.set("v", "<C-x>", dial.dec_visual(), opts)
	vim.keymap.set("v", "g<C-a>", dial.inc_gvisual(), opts)
	vim.keymap.set("v", "g<C-x>", dial.dec_gvisual(), opts)
end

-- PETS
local pets_ok = pcall(require, "pets")
if pets_ok then
	map("n", "<leader>PP", ":PetsPauseToggle<CR>")
	map("n", "<leader>PH", ":PetsHideToggle<CR>")
	map("n", "<leader>PS", ":PetsSleepToggle<CR>")
	vim.keymap.set("n", "<leader>PN", ":PetsNew " .. "gino" .. "<CR>", opts)
end
