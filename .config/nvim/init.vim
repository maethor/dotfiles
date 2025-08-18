" vim: ft=vim et sw=2 foldmethod=marker

" Init {{{1

set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

set inccommand=nosplit

packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('sjl/gundo.vim')
"call minpac#add('vim-scripts/pep8')
"call minpac#add('w0rp/ale') # flakes
call minpac#add('ervandew/supertab')
call minpac#add('tpope/vim-fugitive')
call minpac#add('godlygeek/tabular')
call minpac#add('SirVer/ultisnips')
call minpac#add('vim-scripts/loremipsum')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('othree/html5.vim')
call minpac#add('mitsuhiko/vim-jinja')
call minpac#add('PotatoesMaster/i3-vim-syntax')
call minpac#add('ChrisYip/Better-CSS-Syntax-for-Vim')
call minpac#add('vim-scripts/SyntaxRange')
call minpac#add('averms/black-nvim')
"call minpac#add('wikitopian/hardmode')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('junegunn/limelight.vim')
call minpac#add('junegunn/goyo.vim')
call minpac#add('pearofducks/ansible-vim')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackList call minpac#list()

source ~/.vimrc

"let g:python3_host_prog = '/usr/local/bin/python3.6'

" Key bindings {{{1

" Gundo
nnoremap <F4> :GundoToggle<CR>

" Misc shortcuts
nmap <leader>li :LoremIpsum<CR>

" Tabular
"if exists(":Tabularize")
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
"endif

" UltiSnip

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"

" Hardmode
let g:HardMode_level='wannabe'
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Configuration {{{1

" Yankring
if $USER == 'root'
  let loaded_yankring = 120
endif
let g:yankring_history_file = '.yankring_history'

let g:flake8_quickfix_height=10
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" ansible-vim
"let g:ansible_name_highlight = 'd'
"let g:ansible_extra_keywords_highlight = 1
let g:ansible_normal_keywords_highlight = 'Define'
let g:ansible_with_keywords_highlight = 'Define'

" VimMail
let g:VimMailContactsProvider='khard'
let g:VimMailStartFlags = 'SA'
"let g:VimMailContactQueryCmd="khard email --parsable %s"
let g:VimMailContactSyncCmd="/usr/bin/vdirsyncer sync"
let g:VimMailSpellLangs=['fr','en']
"au Filetype mail set completefunc=vimmail#completion#CompleteAddr
"au Filetype mail set omnifunc=vimmail#completion#CompleteAddr

" CtrlP
" Open in new tab by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
