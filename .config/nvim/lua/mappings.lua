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

-- center after movement
local zz_binds = { "<C-d>", "<C-u>", "n", "N", "<C-o>", "<C-i>" }
for _, c in ipairs(zz_binds) do
  map({ "v", "n" }, c, c .. "zz")
end

-- switch some default mappings
map({ "v", "n" }, "0", "^")
map({ "v", "n" }, "^", "0")
map("v", "p", "P")
map("v", "P", "p")

-- OTHER
-- use sys clipboard
map({ "n", "v" }, "<leader>y", '"+y', "copy to system clipboard")
map({ "n", "v" }, "<leader>p", '"+p', "paste from system clipboard")
-- delete to nil register
map({ "n", "v" }, "<leader>d", '"_d')
map({ "n", "v" }, "<leader>D", '"_D')

-- INSERT MODE
-- add undo points while typing
local chars = { "<Space>", ",", ".", "(", "[", "{", ":", ";" }
for _, c in ipairs(chars) do
  map("i", c, "<C-g>u" .. c)
end
-- fix latest typo
map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

-- VISUAL MODE
-- Maintain selection after indentation
map("v", ">", ">gv")
map("v", "<", "<gv")
-- Move text up and down
map("v", "<M-J>", ":m'>+1<CR>gv=gv")
map("v", "<M-K>", ":m-2<CR>gv=gv")

-- NORMAL MODE
-- toggle scratch buffer
map("n", "<m-n>", ":new<bar>setlocal bt=nofile<cr>")
-- remove highlights with esc
map("n", "<esc>", ":noh<return><esc>")
-- WINDOWS
-- navigate
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-j>", "<C-w><C-j>")
-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")
-- Move text up and down
map("n", "<M-J>", "<Esc>:m .+1<CR>==V")
map("n", "<M-K>", "<Esc>:m .-2<CR>==V")
-- LSP
map("n", "<leader>vd", ":lua vim.lsp.buf.definition()<CR> zz", "lsp go to [D]efinition")
map("n", "<leader>vi", ":lua vim.lsp.buf.implementation()<CR> zz", "lsp go to [I]mplementation")
map("n", "<leader>f<space>", vim.lsp.buf.format, "lsp format")
map("n", "<leader>vf", vim.lsp.buf.format, "lsp [F]ormat")
map("n", "<leader>vh", function()
  local enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not enabled)
  vim.notify("inlay hints enabled: " .. tostring(not enabled), vim.log.levels.INFO, { title = "LSP" })
end, "lsp toggle inlay [H]ints")
map("n", "<leader>vv", function()
  local enabled = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not enabled })
end, "lsp toggle [V]irtual text")
-- tabs
map("n", "<leader>tn", ":tabnew<CR>", "new tab")
map("n", "<leader>th", ":tabprevious<CR>", "prev tab")
map("n", "<leader>tl", ":tabnext<CR>", "next tab")
map("n", "<leader>td", ":bdelete<CR>", "delete tab")
