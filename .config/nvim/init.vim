set clipboard=unnamedplus
highlight Normal ctermbg=none guibg=none

" Set basic colorscheme
set background=dark
colorscheme 002-black-metal

" Define colors manually
highlight Normal      ctermfg=black
highlight String      ctermfg=black
highlight NonText     ctermfg=black
highlight EndOfBuffer ctermfg=black
highlight NormalNC    ctermfg=black
highlight Comment     ctermfg=darkblue
highlight Constant    ctermfg=yellow
highlight Identifier  ctermfg=green
highlight Statement   ctermfg=blue
highlight PreProc     ctermfg=magenta
highlight Type        ctermfg=cyan
highlight Special     ctermfg=red
highlight Todo        ctermfg=black    ctermbg=yellow

" Cursor and Line Numbers
highlight CursorLine  cterm=NONE       ctermbg=gray
highlight LineNr      ctermfg=yellow   ctermbg=NONE
highlight CursorLineNr ctermfg=white   cterm=bold

" Match the status line with your color scheme
highlight StatusLine  ctermfg=white   ctermbg=blue
highlight StatusLineNC ctermfg=white   ctermbg=gray

" For Visual mode selection
highlight Visual      ctermbg=darkcyan

" Syntax highlighting for specific languages
syntax enable
filetype plugin indent on


