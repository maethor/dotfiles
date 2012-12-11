" Vim syntax file
" Language:     Gotchas
" Maintainer:   Guillaume Subiron <maethor@subiron.org>
" Filenames:    *.gotchas

if exists("b:current_syntax")
  finish
endif

syn case ignore

syn region  gotchasString   start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   gotchasComment  "#.*"
syn match   gotchasGotcha   ":.*:"

hi def link gotchasComment           Comment
hi def link gotchasString            String
hi def link gotchasGotcha            Todo

let b:current_syntax = "gotchas"

" vim:set sw=2:
