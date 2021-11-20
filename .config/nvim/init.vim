" INIT
set guifont=Caskaydia\ Cove\ Nerd\ Font

" VIM-PLUG
call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'chrisbra/Colorizer'
Plug 'vim-airline/vim-airline'

call plug#end()

" #############################
" PLUGIN SETTINGS
" #############################
" gruvbox
let g:gruvbox_transparent_bg = 1
autocmd VimEnter * hi Normal ctermbg=none

" colorizer
let g:colorizer_skip_comments = 1
let g:colorizer_colornames = 0

" airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = '暈'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = "\uE0B0"
let g:airline_right_sep = "\uE0B2"

" #############################
" INIT
" #############################
colorscheme gruvbox

set relativenumber 
set number
