-- tabs/indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.cursorline = true

-- APPEARANCE
local function extend_hl(name, def)
	local current_def = vim.api.nvim_get_hl_by_name(name, true)
	local new_def = vim.tbl_extend("force", {}, current_def, def)
	vim.api.nvim_set_hl(0, name, new_def)
end

-- show line numbers
vim.opt.relativenumber = true
vim.opt.number = true
-- font and colorshceme
vim.opt.guifont = "Caskaydia Cove Nerd Font"
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- always show SignColumn

extend_hl("NvimTreeCursorLine", { ctermbg = 1 }) -- Nvim-tree line highlight

-- Transparency
vim.api.nvim_set_hl(0, "BufferlineIndicatorSelected", {}) -- bufferline underline between tabs

local remove_backgound = {
	"GitSignsAdd",
	"GitSignsChange",
	"GitSignsDelete",
	"DiagnosticSignError",
	"DiagnosticSignWarn",
	"DiagnosticSignHint",
	"DiagnosticSignInfo",
	"SignColumn",
	"CursorLine",
	"CursorLineNr",
	"WinBarNC", -- unfocused outline
}
for _, v in ipairs(remove_backgound) do
	extend_hl(v, { bg = "NONE" })
end
