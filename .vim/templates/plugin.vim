" @FILENAME@ - @TITLE@
" Maintainer:   @AUTHOR_EMAIL@

if exists("g:loaded_@BASENAME@") || v:version < 700 || &cp
  finish
endif
let g:loaded_@BASENAME@ = 1

