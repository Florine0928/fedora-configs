" 002-black-metal.vim
" Colorscheme based on Kitty theme BlackMetal by metalelf0

highlight clear
syntax reset

set background=dark
let g:colors_name = '002-darkmode'

" Basic colors
hi Normal guifg=#ffffff guibg=#000000
hi Selection guifg=#000000 guibg=#ffffff

" Foreground and background
hi Normal guifg=#ffffff guibg=#000000
hi Visual guibg=#333333

" Define color palette
hi ColorColumn guibg=#333333
hi CursorLine guibg=#333333
hi LineNr guifg=#888888 guibg=#000000
hi CursorLineNr guifg=#aaaaaa guibg=#000000

" Comments
hi Comment guifg=#5f8787 cterm=italic

" Constants, identifiers, and keywords
hi Constant guifg=#dd9999
hi Identifier guifg=#a06666
hi Keyword guifg=#999999

" UI elements
hi StatusLine guifg=#ffffff guibg=#000000
hi StatusLineNC guifg=#666666 guibg=#000000
hi TabLineSel guifg=#ffffff guibg=#000000
hi TabLine guifg=#666666 guibg=#000000
hi TabLineFill guibg=#000000

" Borders and highlighting
hi VertSplit guifg=#ffffff
hi PmenuSel guibg=#5f8787

" Special
hi Error guifg=#dd9999
hi WarningMsg guifg=#a06666
hi Todo guifg=#aaaaaa guibg=#000000

" Links
hi link Directory Identifier
hi link Title Keyword

