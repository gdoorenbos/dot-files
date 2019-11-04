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

" show tabs and other whitespace characters
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" tab complete options
set wildmode=longest,full
set wildmenu

" highlight searches
set hlsearch

" enable searching for visually selected text with //
vnoremap // y/<C-R>"<CR>

" disable bell sounds
set noerrorbells novisualbell t_vb=

" set syntax for .bats files
autocmd BufRead,BufNewFile *.bats setfiletype sh

" organize swap files into their own directory
set directory^=$HOME/.vim/tmp//

" easier buffer cycling
nnoremap <C-n> :bnext<CR>
nnoremap <C-m> :bprevious<CR>

" plugins (https://github.com/junegunn/vim-plug)
if has('unix')
    let vim_plugged_vimfile = '~/.vim/autoload/plug.vim'
    let vim_plugged_dir = '~/.vim/plugged'
else
    let vim_plugged_vimfile = '~\vimfiles\autoload\plug.vim'
    let vim_plugged_dir = '~\vimfiles\plugged'
    set shell=powershell
    set shellcmdflag=-command
endif
if empty(glob(vim_plugged_vimfile))
    if has('unix')
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !md '~\vimfiles\autoload'
        silent !Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' -OutFile '~\vimfiles\autoload\plug.vim'
    endif
    autocmd VimEnter,GUIEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(vim_plugged_dir)
    Plug 'https://github.com/altercation/vim-colors-solarized.git'
    Plug 'https://github.com/rafi/awesome-vim-colorschemes.git'
    Plug 'https://github.com/widatama/vim-phoenix.git'
    Plug 'https://github.com/tokers/magellan'
    Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
call plug#end()
" end plugins

" color scheme
syntax enable
silent! colorscheme magellan

" powerline
if has('python3') && ! has('gui_running')
    python3 from powerline.vim import setup as powerline_setup
    python3 powerline_setup()
    python3 del powerline_setup
endif
set laststatus=2

" ctags
if has("cscope")
   """"""""""""" Standard cscope/vim boilerplate
   " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
   set cscopetag
   " check cscope for definition of a symbol before checking ctags: set to 1
   " if you want the reverse search order.
   set csto=0
   let CSCOPE_DB=findfile("csctags", ";")
   " add the found database file
   if filereadable(CSCOPE_DB)
      exe "cs add " . CSCOPE_DB
   " else add the database pointed to by environment variable 
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   " show msg when any other cscope db added
   set cscopeverbose  
   """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).

    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  

    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR> 
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR> 

    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left
    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>   
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

    set tags=./tags;
endif
