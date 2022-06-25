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
set lcs=tab:┌─,trail:·,space:·

" Show typed commands
set showcmd

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'justinmk/vim-sneak'

call plug#end()

" Highlight trailing spaces
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
autocmd ColorScheme * match TrailingWhitespace /\s\+$/

" Color scheme
colorscheme codedark
set background=dark

" Set label mode for sneak
let g:sneak#label = 1

" Statusline customization
autocmd InsertEnter * hi ModeMsg term=bold ctermbg=166 ctermfg=0 guifg=#000000 guibg=#d75f00
autocmd InsertLeave * hi ModeMsg term=bold ctermfg=188 ctermbg=235 guifg=#D4D4D4 guibg=#252526
