if executable('shellcheck')
    set makeprg=shellcheck\ -f\ gcc\ -e\ 2045,2044\ %

    let s:quitting = 0
    autocmd QuitPre      * let s:quitting = 1
    autocmd BufWritePost * if ! s:quitting | :silent make | redraw!

    au QuickFixCmdPost [^l]* nested cwindow
    au QuickFixCmdPost    l* nested lwindow
endif
