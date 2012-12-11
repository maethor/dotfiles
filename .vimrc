" vim: ft=vim et sw=2 foldmethod=marker
"                                 
" Vim configuration file          
" Since 2009,  maethor <maethor@subiron.org>
"                                         
"  This file is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY                                    

" Init {{{1

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen plugin manager
"if exists("g:loaded_pathogen")
  call pathogen#infect()
  call pathogen#helptags()
"endif

" Key bindings {{{1

let mapleader = ","

" File actions
imap <c-space> <c-x><c-o>
nmap <c-s-space> zR
nnoremap <space> za
nmap <c-s> :w<CR>
imap <c-s> <c-o>:w<CR>

" Numbers
nmap <leader>n :setlocal number!<CR>
nmap <leader>N :setlocal relativenumber!<CR>

" Vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" Gundo
nnoremap <F4> :GundoToggle<CR>

" Misc shortcuts
nmap <leader>li :LoremIpsum<CR>

" Select the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Sudo to write
command Wsudo w !sudo tee % >/dev/null

" set pastetoggle=<F6>
nnoremap <F6> :set paste!<cr>

" Toggle [i]nvisible characters
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
nnoremap <leader>i :set list!<cr>

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
nmap <F2> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc

" Gotchas Keywords
nmap <leader>g bi:<Esc>ea:maethor:<C-R>=strftime("%y%m%d")<CR><Esc>a:<Esc>

""" Display/Mask TagList window
map <F8> <Esc>:TlistToggle<CR>

" Like bufdo, but restore the current buffer
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

" Autosave when urxvt loose focus
if !has("gui_running")
  exe 'silent !echo -ne "\033]777;focus;on\007"'
  set <F37>=[UlFocusIn
  set <F36>=[UlFocusOut
  map <F37> :Bufdo checktime<CR>
  map  <F36> :wa!<CR>
  map! <F37> <C-O>:Bufdo checktime<CR>
  map! <F36> <C-O>:wa!<CR>
  autocmd VimLeavePre * exe 'silent !echo -ne "\033]777;focus;off\007"'
endif

" Get rid of hl (after a search)
nnoremap <leader><space> :noh<cr>

" Configuration {{{1

" Backup
if has("vms")
  set nobackup
else
  set backup		" keep a backup file
  set backupskip+=*.tmp,crontab.*
endif

" General options {{{2

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

" Editing {{{2

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

" Yankring
if $USER == 'root'
  let loaded_yankring = 120
endif
let g:yankring_history_file = '.yankring_history'

" Formatting {{{2

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

" Style {{{1

" Theme
set background=dark
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=Black gui=NONE guifg=DarkGrey guibg=NONE
highlight ColorColumn term=bold cterm=NONE ctermfg=DarkGrey ctermbg=Black gui=NONE guifg=DarkGrey guibg=NONE

" Badwolf theme
let g:badwolf_darkgutter = 0
let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 1
let g:badwolf_css_props_highlight = 1
colorscheme maethor

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

" Autocmd {{{1

if has("autocmd")
  " Vimrc
  "autocmd bufwritepost .vimrc source $MYVIMRC

  " Open buffers in tabs
  "autocmd BufAdd,BufNewFile * nested tab sball

  " Filetype detection
  autocmd BufNewFile,BufRead *.tex set ft=tex
  autocmd BufNewFile,BufRead *.cls set ft=tex
  autocmd BufNewFile,BufRead *.sty set ft=tex
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set ft=gitcommit
  autocmd BufNewFile,BufRead *.cup set ft=java
  autocmd BufNewFile,BufRead *.zsh-theme set ft=zsh

  " Mutt 
  autocmd BufRead /tmp/mutt* set tw=72 formatoptions+=a spell "colorcolumn=72
  autocmd BufRead /tmp/mutt* let b:textwidth=72
  autocmd BufEnter /tmp/mutt* so ~/.vim/colors/muttcolors.vim

  " Indentation
  autocmd FileType make silent setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType yaml,tex,html,xhtml,htmldjango,xml,plaintex silent setlocal ts=2 sts=2 sw=2

  " cindent
  "autocmd FileType c,cpp setlocal cindent

  " Git: Don't jump to last position, no modeline
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
  autocmd FileType git setlocal nomodeline

  " Tex textwidth
  "autocmd FileType tex setlocal tw=72 formatoptions+=a
  
  " Vim theme
  au BufWritePost badwolf.vim color badwolf
  au BufWritePost maethor.vim color maethor

endif

