"                                 
" Vim configuration file          
" Since 2009,  maethor <maethor@subiron.org>
"                                         
"  This file is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY                                    

"------"
" Init "
"------"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen plugin manager
"if exists("g:loaded_pathogen")
  call pathogen#infect()
  call pathogen#helptags()
"endif

"--------------"
" Key bindings "
"--------------"

let mapleader = ","

" File actions
imap <c-space> <c-x><c-o>
nmap <c-s-space> zR
nnoremap <space> za
nmap <c-s> :w<CR>
imap <c-s> <c-o>:w<CR>

" Vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" Gundo
if exists("g:loaded_gundo")
  nnoremap <F5> :GundoToggle<CR>
endif

" HexHightlight
if exists('*HexHighlight()')
  nmap <leader>h :call HexHighlight()<Return>
endif

" Return to visual mode after indenting
xmap < <gv
xmap > >gv

" Spell check
if exists("+spelllang")
  nmap <silent> <leader>s = :set spell!<CR>
  nmap <leader>ss :set nospell<CR>
  nmap <leader>se :set spell spelllang=en<CR>
  nmap <leader>sf :set spell spelllang=fr_fr<CR>
endif

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc


"---------------"
" Configuration "
"---------------"

" Backup
if has("vms")
  set nobackup
else
  set backup		" keep a backup file
  set backupskip+=*.tmp,crontab.*
endif

" General options
"----------------

set encoding=utf-8  " Use UTF8
set mouse=a         " Use Mouse
set history=50      
set number          " Show line number
set ruler           " Show column number
set showcmd	        " Show chain while typing
set incsearch       " Incremental research
set wildmenu 
set wildignore+=*~,*.aux,tags,*.pyc,*.o,*.pyo,.git,.svn
set suffixes+=.dvi  " Lower priority in wildcards
set smartcase       " Research is case sensitive
set hidden          " Allow hidden buffers with changes 
set showmatch       " Show matching brackets when typed

" Define tags path (ctags)
set tags+=../tags,../../tags,../../../tags,../../../../tags

" Define grep command
set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags

" Be nice and quiet
set noerrorbells
set visualbell
set t_vb=

" Editing
"--------

" Folding
set foldminlines=2      " Don't fold less than 2 lines
set foldmethod=syntax   " By default, syntax folding
set foldlevel=100       " By default, open all folds

" Completion
set omnifunc=synthaxcomplete#Complete

" Par 
if executable("par") 
  set formatprg=par 
endif 

" Spell checking
if exists("+spelllang")
  set spelllang=fr_fr
endif
set dictionary+=/usr/share/dict/words

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Formatting
"-----------

" Indentation
set autoindent		" Always set autoindenting on
filetype plugin indent on
set shiftwidth=4    " Indent with 4 spaces
set tabstop=4       " Use 4 spaces to represent a tab
set expandtab       " Enter spaces to represent a tab
set smarttab

" Syntax
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Soft wrapping
set wrap linebreak nolist
set showbreak=…

"-------"
" Style "
"-------"

" Theme
set background=dark
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=Black gui=NONE guifg=DarkGrey guibg=NONE

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=\ \ \ %{fugitive#statusline()}\  " git branch
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

set showmode

"---------"
" Autocmd "
"---------"

if has("autocmd")
  " Vimrc
  "autocmd bufwritepost .vimrc source $MYVIMRC

  " Filetype detection
  autocmd BufNewFile,BufRead *.tex set ft=tex
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set ft=gitcommit
  autocmd BufNewFile,BufRead *.cup set ft=java

  " Mutt 
  autocmd BufRead /tmp/mutt* set tw=72 formatoptions+=a
  autocmd BufRead /tmp/mutt* let b:textwidth=72
  autocmd BufEnter /tmp/mutt* so ~/.vim/colors/muttcolors.vim

  " Indentation
  autocmd FileType make silent setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType yaml,tex,html,xhtml,xml,plaintex silent setlocal ts=2 sts=2 sw=2

  " cindent
  "autocmd FileType c,cpp setlocal cindent

  " Git: Don't jump to last position, no modeline
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
  autocmd FileType git setlocal nomodeline

  " Tex textwidth
  "autocmd FileType tex setlocal tw=72 formatoptions+=a
endif

" vim:set ft=vim et sw=2:
