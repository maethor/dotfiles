hi mailHeaderKey ctermfg=cyan cterm=bold term=bold
hi mailHeader ctermfg=darkcyan cterm=bold term=bold
hi mailSubject ctermfg=yellow cterm=bold term=bold
hi mailEmail ctermfg=red cterm=bold term=bold
hi mailSignature cterm=bold term=bold
"hi mailSignature ctermfg=darkmagenta
"hi mailQuoted1 ctermfg=darkgreen
"hi mailQuoted2 ctermfg=darkcyan
"hi mailQuoted3 ctermfg=darkmagenta
"hi mailQuoted4 ctermfg=blue
"hi mailQuoted5 ctermfg=darkblue
"hi mailQuoted6 ctermfg=black

syn match mailFrom contained "^From.*"
syn match mailTo contained "^To.*"

hi mailTo ctermfg=yellow term=bold
hi mailFrom ctermfg=yellow term=bold
