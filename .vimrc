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

" Pathogen plugin manager
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

let mapleader = ","

" Spell check
if exists("+spelllang")
    set spelllang=fr_fr 
    nmap <silent> <leader>s = :set spell!<CR>
endif
set dictionary+=/usr/share/dict/words

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupskip+=*.tmp,crontab.*
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu	" show autocomplete menus
set smartcase
set background=dark
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=Black gui=NONE guifg=DarkGrey guibg=NONE
syn on 
set tags+=../tags,../../tags,../../../tags,../../../../tags
set wildignore+=*~,*.aux,tags
set suffixes+=.dvi  " Lower priority in wildcards

" INDENT
set autoindent		" always set autoindenting on
"set foldmethod=indent
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if !has("gui_running") && $DISPLAY == '' || !has("gui")
  set mouse=a
endif


" Soft wrapping
set wrap linebreak nolist
set showbreak=…

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

" vimrc
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

nmap <leader>v :tabedit $MYVIMRC<CR>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" HexHightlight
if exists('*HexHighlight()')
    nmap <leader>h :call HexHighlight()<Return>
endif


" MUTT 

"Par 
"if has("par") 
    set formatprg=par 
"endif 

if has("autocmd")
    au BufRead /tmp/mutt* set tw=72 formatoptions+=a
    au BufEnter /tmp/mutt* so ~/.vim/muttcolors.vim
endif
