lua <<EOF
require('user.options')
require('user.keymaps')
require('user.plugins')
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

" General
let g:python_host_prog = "/home/zoran/virtualenv/neovim_py2/bin/python"
let g:python3_host_prog = "/home/zoran/virtualenv/neovim_py3/bin/python"
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:go_gopls_enabled = 0

" Invoking plugins
nnoremap <leader>f :Grepper<space><cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>n :Lexplore<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>mt :Toc<CR>

" Filetype specific options
augroup filetype_format
  autocmd!
  autocmd BufWritePre *.go :GoFmt
augroup END
let g:vim_markdown_folding_disabled=1

" Gutentags
let g:gutentags_enabled = 0
let g:gutentags_exclude_filetypes = ['vim', 'markdown', 'text', 'config', 'yaml', 'gitcommit', 'gitrebase', 'diff', 'mail', 'beancount']
let g:gutentags_ctags_exclude = ['node_modules/*']

" Paste doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


" Command flubs
command! WQ wq
command! Wq wq
command! W w
command! Q q

nnoremap <silent> <Leader>ce :call local#cscope#do('3', expand('<cword>'))<CR>
" manually fixing syntax highlighting going out of sync
nnoremap <Leader>fh :syntax sync fromstart<CR>

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
