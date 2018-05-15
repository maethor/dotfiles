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
call minpac#add('dbeniamine/vim-mail')
"call minpac#add('wikitopian/hardmode')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('junegunn/limelight.vim')
call minpac#add('junegunn/goyo.vim')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

source ~/.vimrc

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
