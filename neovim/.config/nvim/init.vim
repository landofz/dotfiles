lua <<EOF
require('user.plugins')
require('user.options')
require('user.keymaps')
require('user.colorscheme')
require('user.autocommands')

require('user.statusline')
require('user.treesitter')
require('user.comment')
require('user.indentline')
require('user.gitsigns')
require('user.telescope')
require('user.lsp')
require('user.cmp')
EOF

func! MyNewZettel(...)
  " build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '_'
  endif
  let l:now = localtime()
  let l:id = strftime("%Y%m%d%H%M%S", l:now)
  let l:time = strftime("%Y-%m-%d %H:%M:%S", l:now)
  let l:fname = expand('~/storage/Notebook/') . l:id . l:sep . join(a:000, '-') . '.adoc'
  " edit the new file
  exec "e " . l:fname
  " enter the title, id and timestamp
  if len(a:000) > 0
    exec "normal ggi= " . join(a:000) . "\<cr>:id: " . l:id . "\<cr>:time: " . l:time . "\<esc>G"
  else
    exec "normal ggi= " . l:id . "\<cr>:id: " . l:id . "\<cr>:time: " . l:time . "\<esc>G"
  endif
endfunc

command! -nargs=* Zet call MyNewZettel(<f-args>)
