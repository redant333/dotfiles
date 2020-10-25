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

call plug#end()

" Color scheme
colorscheme codedark
set background=dark
highlight SpecialKey ctermfg=grey guifg=grey70

" Leader mapping
let mapleader = " "

" Set labe label mode for sneak
let g:sneak#label = 1
