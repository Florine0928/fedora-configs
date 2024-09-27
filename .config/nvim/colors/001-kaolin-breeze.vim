" kitty_theme.vim
set background=light

" Define the basic colors
let s:bg = '#EBE8E4'
let s:fg = '#383e3f'
let s:sel_bg = '#383e3f'
let s:sel_fg = '#EBE8E4'
let s:cursor = '#383e3f'
let s:cursor_text = '#EBE8E4'

let s:border_active = '#48a9a9'
let s:border_inactive = '#7D8468'

let s:tab_active_bg = '#383e3f'
let s:tab_active_fg = '#C9C2BD'
let s:tab_inactive_bg = '#7D8468'
let s:tab_inactive_fg = '#EBE8E4'

" 16 color palette
let s:black = '#383e3f'
let s:black_bright = '#7D8468'
let s:red = '#cd5c60'
let s:red_bright = '#ef6787'
let s:green = '#39855f'
let s:green_bright = '#3e594e'
let s:yellow = '#b87e3c'
let s:yellow_bright = '#d1832e'
let s:blue = '#2683b5'
let s:blue_bright = '#4F9CB8'
let s:magenta = '#845A84'
let s:magenta_bright = '#605DB3'
let s:cyan = '#48a9a9'
let s:cyan_bright = '#008b8b'
let s:white = '#C9C2BD'
let s:white_bright = '#60696b'

" Define highlight groups
highlight Normal ctermfg=black ctermbg=white guifg=s:fg guibg=s:bg
highlight Comment ctermfg=black guifg=s:black_bright
highlight Constant ctermfg=red guifg=s:red
highlight Identifier ctermfg=green guifg=s:green
highlight Statement ctermfg=blue guifg=s:blue
highlight PreProc ctermfg=yellow guifg=s:yellow
highlight Type ctermfg=cyan guifg=s:cyan
highlight Special ctermfg=magenta guifg=s:magenta
highlight Todo ctermfg=black ctermbg=yellow guifg=s:black guibg=s:yellow
highlight CursorLine ctermbg=black guibg=s:black
highlight LineNr ctermfg=yellow guifg=s:yellow
highlight CursorLineNr ctermfg=white guifg=s:white
highlight StatusLine ctermfg=white ctermbg=blue guifg=s:white guibg=s:blue
highlight StatusLineNC ctermfg=white ctermbg=black guifg=s:white guibg=s:black
highlight Visual ctermbg=cyan guibg=s:cyan

" Set cursor and border colors
highlight Cursor guifg=s:cursor guibg=s:cursor_text
highlight NormalNC ctermfg=black guifg=s:black_bright
highlight TabLine ctermfg=black ctermbg=yellow guifg=s:black guibg=s:yellow
highlight TabLineFill ctermfg=black ctermbg=black guifg=s:black guibg=s:black
highlight TabLineSel ctermfg=black ctermbg=blue guifg=s:black guibg=s:blue

" Set the terminal colors
let g:terminal_color_0 = s:black
let g:terminal_color_1 = s:red
let g:terminal_color_2 = s:green
let g:terminal_color_3 = s:yellow
let g:terminal_color_4 = s:blue
let g:terminal_color_5 = s:magenta
let g:terminal_color_6 = s:cyan
let g:terminal_color_7 = s:white
let g:terminal_color_8 = s:black_bright
let g:terminal_color_9 = s:red_bright
let g:terminal_color_10 = s:green_bright
let g:terminal_color_11 = s:yellow_bright
let g:terminal_color_12 = s:blue_bright
let g:terminal_color_13 = s:magenta_bright
let g:terminal_color_14 = s:cyan_bright
let g:terminal_color_15 = s:white_bright

