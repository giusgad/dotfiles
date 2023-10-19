local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- normal_mode = "n", insert_mode = "i", visual_mode = "v", visual_block_mode = "x", term_mode = "t", command_mode = "c",
-- LEADER is mapped in init for lazyloading to work

local buffer_opts = { noremap = true, silent = true, buffer = true }

-- remove stupid annoying thing
map({ "n", "v" }, "q:", "<nop>")
-- remap <C-w> for buffers
map("n", "<C-q>", "<C-w>")

-- TERM
map("t", "<C-esc>", "<C-\\><C-n>")
map("t", "<M-v>", "<C-\\><C-n>")

-- MOVEMENTS
-- center cursor when going down or up by half pages
map({ "v", "n" }, "<C-d>", "<C-d>zz")
map({ "v", "n" }, "<C-u>", "<C-u>zz")
-- center cursor when searching
map({ "v", "n" }, "n", "nzz")
map({ "v", "n" }, "N", "Nzz")
-- center marker after jump
-- map("n", "'", "\"'\" . nr2char(getchar()) . 'zz'") TODO
map({ "v", "n" }, "0", "^")
map({ "v", "n" }, "^", "0")
map({ "v", "n" }, "<C-%>", "$%")

-- OTHER
-- use sys clipboard
map({ "n", "v" }, "<leader>y", '"+y', "copy to system clipboard")
map({ "n", "v" }, "<leader>p", '"+p', "paste from sysstem clipboard")
-- delete to nil register
map({ "n", "v" }, "<leader>d", '"_d')
map({ "n", "v" }, "<leader>D", '"_D')
-- add undo points while typing
local chars = { "<Space>", ",", ".", "(", "[", "{", ":", ";" }
for _, c in ipairs(chars) do
    map("i", c, "<C-g>u" .. c)
end

-- VISUAL MODE
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
--[[ map("n", "<C-h>", "<C-w>h",opts)
map("n", "<C-j>", "<C-w>j",opts)
map("n", "<C-k>", "<C-w>k",opts)
map("n", "<C-l>", "<C-w>l",opts) ]]
-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")
-- Move text up and down
map("n", "<M-J>", "<Esc>:m .+1<CR>==V")
map("n", "<M-K>", "<Esc>:m .-2<CR>==V")
-- LSP
map("n", "<leader>vd", ":lua vim.lsp.buf.definition()<CR> zz", "lsp go to definition")
map("n", "<leader>vi", ":lua vim.lsp.buf.implementation()<CR> zz", "lsp go to implementation")
map("n", "<leader>f<space>", ":lua vim.lsp.buf.format()<CR>", "lsp format")
map("n", "<leader>vf", ":lua vim.lsp.buf.format()<CR>", "lsp format")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",opts)
-- map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",opts)
-- map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>",opts)
-- tabs
map("n", "<leader>tn", ":tabnew<CR>", "new tab")
map("n", "<leader>th", ":tabprevious<CR>", "prev tab")
map("n", "<leader>tl", ":tabnext<CR>", "next tab")
map("n", "<leader>td", ":bdelete<CR>", "delete tab")

-- PLUGINS
-- HARPOON
local ok, mark = pcall(require, "harpoon.mark")
if ok then
    local ui = require("harpoon.ui")
    map("n", "<leader>a", mark.add_file, "add to harpoon")
    map("n", "<C-f>", ui.toggle_quick_menu)
    -- stylua: ignore start
    map("n", "<leader>h", function() ui.nav_file(1) end, "harpoon jump")
    map("n", "<leader>j", function() ui.nav_file(2) end, "harpoon jump")
    map("n", "<leader>k", function() ui.nav_file(3) end, "harpoon jump")
    map("n", "<leader>l", function() ui.nav_file(4) end, "harpoon jump")
    -- stylua: ignore end
end
-- NOTIFY
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
    map({ "n", "v" }, "<leader>n", notify.dismiss)
end
-- LSPSAGA
local saga_ok, _ = pcall(require, "lspsaga")
if saga_ok then
    map("n", "<leader>vh", "<cmd>Lspsaga finder<CR>", "lsp show references") -- view all options
    map({ "n", "v" }, "<leader>va", "<cmd>Lspsaga code_action<CR>", "lsp code action") -- code action
    map("n", "<leader>vr", "<cmd>Lspsaga rename<CR>", "lsp rename") -- rename
    map("n", "<leader>vD", "<cmd>Lspsaga peek_definition<CR>", "lsp peek definition") -- definition in floating window
    map("n", "<leader>vl", "<cmd>Lspsaga show_line_diagnostics<CR>", "lsp line diagnostics") -- show line diagnostics
    map("n", "<leader>vc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "lsp cursor diagnostics") -- show cursor diagnostic
    map("n", "<leader>vo", "<cmd>Lspsaga outline<CR>", "lsp outline") -- outline
    map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "hover doc") -- hover docs
    map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "prev diagnostic") -- jump to diagnostics
    map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", "next diagnostic") -- jump to diagnostics
    map("n", "[E", function() -- jump to errors
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, "prev error")
    map("n", "]E", function() -- jump to errors
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, "next error")
end

-- GITSIGNS
local gs_ok, gs = pcall(require, "gitsigns")
if gs_ok then
    map("n", "<leader>gp", gs.preview_hunk, "git preview hunk")
    map("n", "<leader>gd", gs.diffthis, "git diff")
    map("n", "<leader>gD", function()
        local branch = vim.fn.input({ prompt = "branch to diff against:", default = "main", cancelreturn = "main" })
        gs.diffthis(branch)
    end, "git diff on custom branch")
    map("n", "<leader>gr", gs.reset_hunk, "git reset hunk")
    map("n", "<leader>gR", gs.reset_buffer, "git reset buffer")
    map("n", "<leader>gh", gs.stage_hunk, "git stage hunk")
    map("n", "<leader>gs", gs.stage_buffer, "git stage buffer")
    map("n", "<leader>gv", gs.toggle_deleted, "git view deleted")
    map("n", "[h", gs.prev_hunk, "git prev hunk")
    map("n", "]h", gs.next_hunk, "git next hunk")
end
-- TROUBLE
local trouble_ok, _ = pcall(require, "trouble")
if trouble_ok then
    map("n", "<leader>vt", require("trouble").toggle, "lsp show all errors (trouble)")
end

-- TELESCOPE
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
    map("n", "<leader>ff", builtin.find_files, "telescope find files")
    map("n", "<leader>fb", ":Telescope file_browser<CR>", "telescope find files")
    map("n", "<leader>fe", builtin.diagnostics, "telescope diagnostics")
    map("n", "<leader>fE", function()
        builtin.diagnostics({ bufnr = 0 })
    end, "telescope buffer diagnostics")
    map("n", "<leader>fg", builtin.live_grep, "telescope grep")
    map("n", "<leader>fh", builtin.buffers, "telescope buffers")
    map("n", "<leader>fn", ":Telescope notify<CR>", "telescope notifications")
    map("n", "<leader>ft", ":TodoTelescope<CR>", "telescope TODOs")
    -- worktrees
    map("n", "<leader>gtl", require("telescope").extensions.git_worktree.git_worktrees, "git worktree list/switch")
    map("n", "<leader>gtn", require("telescope").extensions.git_worktree.create_git_worktree, "git worktree add/new")
end

-- DAP
local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
local persist_bp_ok, persist_bp = pcall(require, "persistent-breakpoints.api")
if persist_bp_ok then
    map("n", "<leader>bb", persist_bp.toggle_breakpoint, "dap toggle breakpoint")
    map("n", "<leader>bB", persist_bp.set_conditional_breakpoint, "dap conditional breakpoint")
    map("n", "<leader>bR", persist_bp.clear_all_breakpoints, "dap remove all breakpoints")
end
if dapui_ok then
    map("n", "<leader>bv", dapui.toggle)
end
if dap_ok then
    map("n", "<leader>bc", dap.continue, "dap continue")
    map("n", "<leader>bi", dap.step_into, "dap step into")
    map("n", "<leader>bo", dap.step_over, "dap step over")
    map("n", "<leader>bu", dap.step_out, "dap step out")
end
-- dap-go
local dap_go_ok, dap_go = pcall(require, "dap-go")
if vim.fn.expand("%:e") == "go" and dap_go_ok then
    vim.keymap.set("n", "<leader>bt", dap_go.debug_test, buffer_opts)
    vim.keymap.set("n", "<leader>bT", dap_go.debug_test, buffer_opts)
end

-- UNDOTREE
map("n", "<leader>u", vim.cmd.UndotreeToggle, "undo tree")

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

    map("n", "<leader>gg", _lazygit_toggle, "lazygit term")
    map("t", "<M-k>", _lazygit_toggle)

    -- numbered terminals
    for i = 1, 10, 1 do -- create separate terminals
        map("n", "<leader>g" .. i, ":" .. i .. "ToggleTerm<CR>", "open new term id:" .. i)
    end
end

-- SESSION MANAGER
map("n", "<leader>sl", ":SessionManager load_session<CR>", "session load")

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
    map("n", "<C-a>", dial.inc_normal())
    map("n", "<C-x>", dial.dec_normal())
    map("v", "<C-a>", dial.inc_visual())
    map("v", "<C-x>", dial.dec_visual())
    map("v", "g<C-a>", dial.inc_gvisual())
    map("v", "g<C-x>", dial.dec_gvisual())
end

-- PETS
local pets_ok = pcall(require, "pets")
if pets_ok then
    map("n", "<leader>PP", ":PetsPauseToggle<CR>")
    map("n", "<leader>PH", ":PetsHideToggle<CR>")
    map("n", "<leader>PS", ":PetsSleepToggle<CR>")
    map("n", "<leader>PN", ":PetsNew " .. "gino" .. "<CR>")
end

-- NABLA
local nabla_ok, nabla = pcall(require, "nabla")
if nabla_ok then
    map("n", "<leader>mp", nabla.popup)
    map("n", "<leader>mv", nabla.toggle_virt)
end
