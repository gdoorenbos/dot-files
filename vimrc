set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

set autoindent      " Turn on auto-indent

set smartindent     " smart indent for programs

set nowrap          " don't line wrap

set number          " show line numbers

set t_BE=           " turn off bracketed paste mode. 
                    " prevents appending 0~ and 1~ to the beginning and end of pasted text in terminator.

" show tabs
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" tab complete options
set wildmode=longest,full
set wildmenu

" plugins
call plug#begin('~/.vim/plugged')
"    Plug 'https://github.com/jiangmiao/auto-pairs'
    Plug 'https://github.com/altercation/vim-colors-solarized.git'
    Plug 'https://github.com/rafi/awesome-vim-colorschemes.git'
    Plug 'https://github.com/widatama/vim-phoenix.git'
"    Plug 'https://github.com/Dru89/vim-adventurous'
"    Plug 'https://github.com/Siphalor/vim-atomified'
call plug#end()

syntax enable
set background=dark
colorscheme solarized
" colorscheme meta5
" colorscheme molokai
" colorscheme phoenix
