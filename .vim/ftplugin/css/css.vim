" vim: ft=vim et sw=2 foldmethod=marker
"                                 
" CSS plugin for Vim 
" Since 2013,  maethor <maethor@subiron.org>
"                                         
"  This file is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY                                    
"
"  Inspired by Ulhume, thanks to him !
"  http://artisan.karma-lab.net/vim-et-feuilles-style

setlocal iskeyword+=.,-,#

" Compress / Expand blocks
map <silent> <buffer> <leader>c /}<CR>V?{<CR>J:let @/=""<CR>
map <silent> <buffer> <leader>x V:s/\v[{;]\s*/\0\r/g<CR>V%=:let @/=""<CR>
