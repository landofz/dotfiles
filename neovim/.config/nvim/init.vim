lua <<EOF
require('user.options')
require('user.plugins')
require('user.treesitter')
require('user.comment')
require('user.indentline')
require('user.gitsigns')

local tactions = require("telescope.actions")
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = tactions.close,
        ["<C-j>"] = tactions.move_selection_next,
        ["<C-k>"] = tactions.move_selection_previous,
      }
    },
    file_ignore_patterns = { "^[.]git/" },
  },
})
require('telescope').load_extension('fzf')
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({hidden = true, follow = true})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local my_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>drn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>df', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_on_attach,
    capabilities = capabilities,
  }
end

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

" Diagnostics
nnoremap  <leader>de :lua vim.diagnostic.open_float()<CR>
nnoremap  [d         :lua vim.diagnostic.goto_prev()<CR>
nnoremap  ]d         :lua vim.diagnostic.goto_next()<CR>
nnoremap  <leader>dq :lua vim.diagnostic.setloclist()<CR>

" Movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Appearance
syntax on
set background=dark
if (has("termguicolors"))
  set termguicolors
endif
colorscheme gruvbox
if has("gui_running")
  set guifont=Monospace\ 12
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#gutentags#enabled = 1

" Show tabstops, trailing spaces and EOLs
set list
set listchars=tab:▸\ ,trail:·,eol:¬

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
