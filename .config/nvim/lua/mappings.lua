function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

map("v", "<C-C>", ":w !xclip -i -sel c<CR><CR>") 

-- IMPORT plugin mappings
require("plugins.config.telescope.mappings")
require("plugins.config.null-ls.mappings")
