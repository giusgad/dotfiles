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
local helpers = require("helpers")
for _, v in ipairs(remove_backgound) do
  helpers.extend_hl(v, { bg = "bg" })
end
