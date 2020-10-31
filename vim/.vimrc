" Take indentation into account when creating a new line
set smartindent

" Line numbers
set nu

" Smartcase for searches
set ignorecase
set smartcase

" Incremental search
set incsearch

" Show whitespace
set list lcs=tab:┌─,trail:·

" Show typed commands
set showcmd

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'mg979/vim-visual-multi'
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'

call plug#end()

" Color scheme
colorscheme codedark
set background=dark

" Key mapping
let mapleader = " "
map <leader>T :NERDTreeFind<cr>

" Set labe label mode for sneak
let g:sneak#label = 1

