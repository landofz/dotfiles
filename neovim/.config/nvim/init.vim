lua <<EOF
require('user.options')
require('user.plugins')
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

" Center view on search result
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Keys
let mapleader = ","
inoremap jj <Esc>
cnoremap jj <Esc>

" Editing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" General bindings
nnoremap <leader>w :w<CR>
" nnoremap <CR> G
" nnoremap <BS> gg
nnoremap <leader>l :b#<cr>
nnoremap <leader>% :let @" = expand("%")<cr>  " get current filename

" Quickfix/location
nnoremap <leader>qq :cclose<cr>
nnoremap <leader>qc :exe "crewind " . v:count1<cr>

" Invoking plugins
" nnoremap <leader>p :Files<cr>
" nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Grepper<space><cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>mt :Toc<CR>
nnoremap <leader>b :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>p :lua require('telescope.builtin').find_files({hidden = true})<CR>
nnoremap <leader>gs :lua require('gitsigns').stage_hunk()<CR>

" Movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Appearance
set background=dark
colorscheme gruvbox
let g:airline_powerline_fonts = 1
let g:airline#extensions#gutentags#enabled = 1

" Filetype specific options
augroup filetype_indents
  autocmd!
  autocmd FileType javascript,typescript,typescriptreact,json,yaml,html,htmldjango setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType scss setlocal et ts=2 sw=2
  autocmd FileType yaml setlocal et ts=2 sw=2
augroup END
augroup filetype_generic
  autocmd!
  autocmd FileType mail setlocal spell
augroup END
augroup filetype_format
  autocmd!
  autocmd BufWritePre *.go :GoFmt
augroup END
let g:vim_markdown_folding_disabled=1

" NERDTree
let g:NERDTreeIgnore = ['\~$', '.pyc$[[file]]']
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Gutentags
let g:gutentags_exclude_filetypes = ['vim', 'markdown', 'text', 'config', 'yaml', 'gitcommit', 'gitrebase', 'diff', 'mail']
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

" Don't interrupt v-mode due indent
vnoremap < <gv
vnoremap > >gv

" Command flubs
command! WQ wq
command! Wq wq
command! W w
command! Q q

nnoremap <silent> <Leader>sw :call MyStripTrailingWhitespace()<CR>
nnoremap <silent> <Leader>ce :call local#cscope#do('3', expand('<cword>'))<CR>
" manually fixing syntax highlighting going out of sync
nnoremap <Leader>fh :syntax sync fromstart<CR>

augroup yank_highlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout=250})
augroup end

" handling .gpg files
if !empty($GPG_KEYID)
  augroup filetype_gpg
    au!
    " Use gpg2 to open a .gpg file
    au  BufReadPre,FileReadPre  *.gpg       set nobackup
    au  BufReadPre,FileReadPre  *.gpg       set noswapfile
    au  BufReadPre,FileReadPre  *.gpg       set noundofile
    au  BufReadPre,FileReadPre  *.gpg       set nowritebackup
    au  BufReadPre,FileReadPre  *.gpg       set viminfo=
    au  BufReadPre,FileReadPre  *.gpg       set sh=/bin/bash
    au  BufReadPost             *.gpg       :%!gpg2 -q -d
    au  BufReadPost             *.gpg       | redraw
    au  BufWritePre             *.gpg       :%!gpg2 -q -e --no-encrypt-to --no-default-recipient -r $GPG_KEYID -a
    au  BufWritePost            *.gpg       u
    au  VimLeave                *.gpg       :!clear
  augroup END
endif

func! MyStripTrailingWhitespace()
  let l:_s=@/
  let l:l = line('.')
  let l:c = line('.')
  %s/\s\+$//e
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction

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
