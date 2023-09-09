-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",
-- LEADER is mapped in init for lazyloading to work

local opts = { noremap = true, silent = true }
local buffer_opts = { noremap = true, silent = true, buffer = true }

-- remove stupid annoying thing
vim.keymap.set({ "n", "v" }, "q:", "<nop>", opts)
-- remap <C-w> for buffers
vim.keymap.set("n", "<C-q>", "<C-w>", opts)

-- TERM
vim.keymap.set("t", "<C-esc>", "<C-\\><C-n>", opts)

-- MOVEMENTS
-- center cursor when going down or up by half pages
vim.keymap.set({ "v", "n" }, "<C-d>", "<C-d>zz", opts)
vim.keymap.set({ "v", "n" }, "<C-u>", "<C-u>zz", opts)
-- center cursor when searching
vim.keymap.set({ "v", "n" }, "n", "nzz", opts)
vim.keymap.set({ "v", "n" }, "N", "Nzz", opts)
-- center marker after jump
-- vim.keymap.set("n", "'", "\"'\" . nr2char(getchar()) . 'zz'") TODO
vim.keymap.set({ "v", "n" }, "0", "^", opts)
vim.keymap.set({ "v", "n" }, "^", "0", opts)
vim.keymap.set({ "v", "n" }, "<C-%>", "$%", opts)

-- OTHER
-- use sys clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", 'o<esc>"+p')
-- delete to nil register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
-- add undo points while typing
vim.keymap.set("i", "<Space>", "<C-g>u<Space>", opts)
-- vim.keymap.set("i", "<CR>", "<C-g>u<CR>",opts) -- breaks autopairs
vim.keymap.set("i", ",", "<C-g>u,", opts)
vim.keymap.set("i", ".", "<C-g>u.", opts)
vim.keymap.set("i", "(", "<C-g>u(", opts)
vim.keymap.set("i", "[", "<C-g>u[", opts)
vim.keymap.set("i", "{", "<C-g>u{", opts)

-- VISUAL MODE
-- Copy
vim.keymap.set("v", "<C-C>", ":w !xclip -i -sel c<CR><CR>gv", opts) -- BUG: always copies the whole line
-- Maintain selection after indentation
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)
-- Move text up and down
vim.keymap.set("v", "<M-J>", ":m'>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<M-K>", ":m-2<CR>gv=gv", opts)
-- Delete selected text on paste
vim.keymap.set("v", "p", '"_dP', opts)

-- NORMAL MODE
-- remove highlights with esc
vim.keymap.set("n", "<esc>", ":noh<return><esc>", opts)
-- cursor history
vim.keymap.set("n", "<C-o>", "<C-o>zz", opts)
vim.keymap.set("n", "<C-i>", "<C-i>zz", opts)
-- Window navigation - now integrated with tmux navigator
--[[ vim.keymap.set("n", "<C-h>", "<C-w>h",opts)
vim.keymap.set("n", "<C-j>", "<C-w>j",opts)
vim.keymap.set("n", "<C-k>", "<C-w>k",opts)
vim.keymap.set("n", "<C-l>", "<C-w>l",opts) ]]
-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Move text up and down
vim.keymap.set("n", "<M-J>", "<Esc>:m .+1<CR>==V", opts)
vim.keymap.set("n", "<M-K>", "<Esc>:m .-2<CR>==V", opts)
-- Open nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- LSP
vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts) -- TODO: zz not working
vim.keymap.set("n", "<leader>f<space>", ":lua vim.lsp.buf.format()<CR>", opts)
vim.keymap.set("n", "<leader>vf", ":lua vim.lsp.buf.format()<CR>", opts)
-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",opts)
-- vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",opts)
-- vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>",opts)
-- tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>th", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", opts)
vim.keymap.set("n", "<leader>td", ":bdelete<CR>", opts)

-- PLUGINS
-- HARPOON
local ok, mark = pcall(require, "harpoon.mark")
if ok then
    local ui = require("harpoon.ui")
    vim.keymap.set("n", "<leaer>w", "qa!")
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-f>", ui.toggle_quick_menu)
    -- stylua: ignore start
    vim.keymap.set("n", "<leader>h", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>j", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>k", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>l", function() ui.nav_file(4) end)
    -- stylua: ignore end
end
-- NOTIFY
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
    vim.keymap.set({ "n", "v" }, "<leader>n", notify.dismiss)
end
-- LSPSAGA
local saga_ok, _ = pcall(require, "lspsaga")
if saga_ok then
    vim.keymap.set("n", "<leader>vh", "<cmd>Lspsaga finder<CR>", opts) -- view all options
    vim.keymap.set({ "n", "v" }, "<leader>va", "<cmd>Lspsaga code_action<CR>", opts) -- code action
    vim.keymap.set("n", "<leader>vr", "<cmd>Lspsaga rename<CR>", opts) -- rename
    vim.keymap.set("n", "<leader>vD", "<cmd>Lspsaga peek_definition<CR>", opts) -- definition in floating window
    vim.keymap.set("n", "<leader>vl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show line diagnostics
    vim.keymap.set("n", "<leader>vc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show cursor diagnostic
    vim.keymap.set("n", "<leader>vo", "<cmd>Lspsaga outline<CR>", opts) -- outline
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- hover docs
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to diagnostics
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to diagnostics
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
    vim.keymap.set("n", "<leader>fh", builtin.buffers, opts)
    vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>", opts)
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
        vim.keymap.set("n", "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>", opts)
    end
end

-- SESSION MANAGER
vim.keymap.set("n", "<leader>sl", ":SessionManager load_session<CR>", opts)

-- BUFFERLINE
local bufferline_ok = pcall(require, "bufferline")
if bufferline_ok then
    vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
    vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
    vim.keymap.set("n", "<leader>th", ":BufferLineMovePrev<CR>", opts)
    vim.keymap.set("n", "<leader>tl", ":BufferLineMoveNext<CR>", opts)
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
    vim.keymap.set("n", "<leader>PP", ":PetsPauseToggle<CR>", opts)
    vim.keymap.set("n", "<leader>PH", ":PetsHideToggle<CR>", opts)
    vim.keymap.set("n", "<leader>PS", ":PetsSleepToggle<CR>", opts)
    vim.keymap.set("n", "<leader>PN", ":PetsNew " .. "gino" .. "<CR>", opts)
end
