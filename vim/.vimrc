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

call plug#end()

" Color scheme
colorscheme codedark
set background=dark

" Key mapping
let mapleader = " "
map <leader>T :NERDTreeFind<cr>

" Set labe label mode for sneak
let g:sneak#label = 1

" Statusline customization
autocmd InsertEnter * hi ModeMsg term=bold ctermbg=166 ctermfg=0 guifg=#000000 guibg=#d75f00
autocmd InsertLeave * hi ModeMsg term=bold ctermfg=188 ctermbg=235 guifg=#D4D4D4 guibg=#252526
