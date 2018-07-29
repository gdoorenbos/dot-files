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

colorscheme default  " Use default color scheme

" show whitespace
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

