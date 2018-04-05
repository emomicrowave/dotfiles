"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'sebastianmarkow/deoplete-rust'
Plug 'shougo/neoinclude.vim'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'mhartington/oceanic-next'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"basic stuff
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

"useful standard mappings
inoremap jk <esc>
noremap <C-l> :noh<CR>

"learn to use vim like a pro
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

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
"-----PLUGIN SETTINGS -----
"--------------------------

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "complete"
let g:deoplete#enable_smart_case = 1
"let g:deoplete#disable_auto_complete = 1

augroup omnifuncs
	autocmd!
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end

"tab completion and toggle
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <C-d> <ESC>:call deoplete#toggle()<CR>a

let g:racer_cmd=globpath("$HOME","/.cargo/bin/racer")
let g:racer_experimental_completer=1
let g:deoplete#sources#rust#racer_binary=globpath("$HOME","/.cargo/bin/racer")
let g:deoplete#sources#rust#rust_source_path=expand("$RUST_SRC_PATH")
let g:deoplete#sources#rust#show_duplicates=1
let g:deoplete#sources#rust#documentation_max_height=20

"NerdTree
noremap <C-n> :NERDTreeToggle<CR>


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
