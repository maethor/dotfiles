"                                 
" Vim configuration file          
" Since 2009,  maethor <maethor@subiron.org>
"                                         
"  This file is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY                                    
"                                                      

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu	" show autocomplete menus
set background=dark
"set number
syn on 
set mouse=a
set autoindent		" always set autoindenting on

"set foldmethod=indent
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention and 
" I didn't find a good reason to not use it everywhere.
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Be nice and quiet
set noerrorbells
set visualbell
set t_vb=

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

set showmode

set foldmethod=syntax                           " Activer les replis
set foldlevel=100                               " Ouvrir tout les replis par defaut

" Completion
set omnifunc=synthaxcomplete#Complete

" Bindkeys
imap <c-space> <c-x><c-o>
nmap <c-s-space> zR
nnoremap <space> za
nmap <c-s> :w<CR>
imap <c-s> <c-o>:w<CR>

" MUTT
au BufRead ~/.tmp/mutt* set tw=72
au BufEnter ~/.tmp/mutt* so ~/.vim/mutt.colors
