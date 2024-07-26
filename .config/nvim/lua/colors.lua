local function extend_hl(name, def)
  local current_def = vim.api.nvim_get_hl_by_name(name, true)
  local new_def = vim.tbl_extend("force", {}, current_def, def)
  vim.api.nvim_set_hl(0, name, new_def)
end

vim.o.background = "dark"
vim.opt.termguicolors = true

-- extend_hl("@function.call", { link = "GruvboxAqua" }) -- differentiate variable names from strings

-- floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

-- Transparency
local remove_backgound = {
  "GitSignsAdd",
  "GitSignsChange",
  "GitSignsDelete",
  "DiagnosticSignError",
  "DiagnosticSignWarn",
  "DiagnosticSignHint",
  "DiagnosticSignInfo",
  "SignColumn",
  -- "CursorLine",
  -- "CursorLineNr",
  "WinBarNC", -- unfocused outline
}
for _, v in ipairs(remove_backgound) do
  extend_hl(v, { bg = "bg" })
end
