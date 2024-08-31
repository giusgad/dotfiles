vim.o.wrap = true
vim.o.conceallevel = 2

-- fold
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldmethod = "expr"
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.foldenable = true

local h = require("helpers")
h.extend_hl("markdownItalic", { link = "GruvboxYellow" })
