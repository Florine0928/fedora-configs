	set clipboard=unnamedplus
highlight Normal ctermbg=none guibg=none

" Set basic colorscheme
set background=dark
colorscheme 002-black-metal

" Airline Theme
" google-dark

" Vimplug
call plug#begin()
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'shougo/neocomplete.vim'
Plug 'w0rp/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Syntax highlighting for specific languages
syntax enable
filetype plugin indent on


