func! local#zettel#edit(...)

  " build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '_'
  endif
  let l:fname = expand('~/storage/Notebook/') . strftime("%F_%H-%M-%S") . l:sep . join(a:000, '-') . '.adoc'

  " edit the new file
  exec "e " . l:fname
endfunc
