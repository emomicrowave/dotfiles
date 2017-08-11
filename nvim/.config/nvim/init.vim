"nvim plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mhartington/oceanic-next'
call plug#end()

syntax enable

set ignorecase
set smartcase
set number

"tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4

"keep indent when pressing Ctrl+Enter
set autoindent

"use <j+k> to exit insert mode
inoremap jk <esc>

"coolstuff
set wildmenu
set path=$PWD/**
set hidden " allow closing buffers without saving

"nvim stuff
set termguicolors


"colorscheme
colorscheme OceanicNext

"terminal stuff
tnoremap <ESC> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
tnoremap <M-q> <C-\><C-n><C-w>q

"--------------------------
"------- FUNCTIONS --------
"--------------------------

"filaret's cool blockmove function
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

command! -nargs=1 VisMove
      \ | let test2= substitute(s:get_visual_selection(), "\\s", "", "g")
      \ | let test1= substitute(@1, "\\s", "", "g")
      \ | let test1= substitute(test1, "\\n$", "", "")
      \ | let jojo_len = line("'>") - line("'<")
      \ | let vismove = ":norm gvd".(<args> ==? "up" ? "kP" : "p")
      \ | let vismove .= "V".(jojo_len ==? "0" ? "=gv" : jojo_len."j=gv")
      \ | if (test1 ==? test2) | try | execute ':undojoin'
      \ | catch | endtry | endif
      \ | execute vismove

vnoremap <silent> <c-j> :<C-u>silent! VisMove "down"<cr>
vnoremap <silent> <c-k> :<C-u>silent! VisMove "up"<cr>
