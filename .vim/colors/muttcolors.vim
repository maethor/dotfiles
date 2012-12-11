syn match mailFrom contained "^From.*"
syn match mailTo contained "^To.*"

hi def link mailTo mailHeaderKey
hi def link mailFrom mailHeaderKey
