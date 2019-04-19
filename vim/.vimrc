" For installing vundle use:
"   git clone https://github.com/VundleVim/Vundle.vim.git \
"     ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tmux-plugins/vim-tmux-focus-events' " FocusGained and FocusLost autocommand events in terminal
Plugin 'scrooloose/nerdtree'                " a tree explorer plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'        " a plugin for NERDTree showing git status
Plugin 'junegunn/fzf'                       " fzf installation
Plugin 'junegunn/fzf.vim'                   " use fzf in vim
Plugin 'mbbill/undotree'                    " undo history visualizer
Plugin 'scrooloose/nerdcommenter'           " commenting support
Plugin 'tpope/vim-fugitive'                 " git wrapper
Plugin 'tpope/vim-repeat'                   " repeat plugin maps with '.'
Plugin 'tpope/vim-surround'                 " surrounding made easier
Plugin 'tpope/vim-eunuch'                   " helpers for unix
Plugin 'gregsexton/gitv'                    " a repository viewer similar to gitk
Plugin 'wellle/targets.vim'                 " additional text objects like , . : =
Plugin 'michaeljsmith/vim-indent-object'    " text object based on indentation level
Plugin 'rhysd/clever-f.vim'                 " better repeat and marks for f and t mappings
Plugin 'easymotion/vim-easymotion'          " simpler way to use motions
Plugin 'geoffharcourt/vim-matchit'          " extended '%' matchings
" Snippets
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"Plugin 'honza/vim-snippets'

Plugin 'fatih/vim-go'                       " Go development
Plugin 'isRuslan/vim-es6'
Plugin 'mattn/emmet-vim'                    " HTML and CSS high speed coding
Plugin 'plasticboy/vim-markdown'            " markdown mode

Plugin 'ervandew/supertab'                  " perform all insert mode completions with Tab
Plugin 'vim-airline/vim-airline'            " status/tabline
Plugin 'airblade/vim-gitgutter'             " shows a git diff in the gutter
Plugin 'mhinz/vim-grepper'                  " asynchronous search
Plugin 'ludovicchabant/vim-gutentags'       " manages tag files
Plugin 'majutsushi/tagbar'                  " displays tags in a window, ordered by scope

" Colorschemes
Plugin 'joshdick/onedark.vim'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lisposter/vim-blackboard'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'wgibbs/vim-irblack'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'

call vundle#end()
filetype plugin indent on

" Security
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" General
set shell=sh       " handle case when $SHELL is fish for example
if !has("nvim")
    set encoding=utf-8
endif
if has("nvim")
    set guicursor=n-c:block,i-ci-ve:ver40,r-cr-v:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
endif
set hidden
set scrolloff=3
set showmode
set showcmd
set number         " show line numbers
set relativenumber " use relative line numbers
set ruler          " show cursor position
set laststatus=2   " always show status line
set guioptions-=L  " no left-hand scrollbar
set guioptions-=m  " no menu bar
set guioptions-=r  " no right-hand scrollbar
set guioptions-=T  " no toolbar
" don't write any backups
set nobackup
set nowritebackup
" don't write swap files
set noswapfile
set visualbell
set noerrorbells
set wildmenu
set showmatch

" Search
set incsearch      " search dynamically while typing
set hlsearch       " highlight searches
set ignorecase     " ignore case during search
set smartcase

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
nnoremap <CR> G
nnoremap <BS> gg
nnoremap <leader>l :b#<cr>

" Quickfix/location
nnoremap <leader>qq :cclose<cr>
nnoremap <leader>qc :exe "crewind " . v:count1<cr>

" Invoking plugins
nnoremap <leader>p :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Grepper<space><cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>g :UndotreeToggle<CR>
nnoremap <leader>mt :Toc<CR>

" Movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Appearance
syntax on
set background=dark
colorscheme default
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
    autocmd FileType javascript,json,yaml,html,htmldjango setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" NERDTree
let g:NERDTreeIgnore = ['\~$', '.pyc$[[file]]']
let g:NERDTreeIndicatorMapCustom = {
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
let g:gutentags_exclude_filetypes = ['vim', 'markdown', 'text', 'config', 'yaml']

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

" Deletes trailing whitespace
function! StripTrailingWhitespace()
  let l:_s=@/
  let l:l = line('.')
  let l:c = line('.')
  %s/\s\+$//e
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction
nnoremap <Leader>sw :call StripTrailingWhitespace()<CR>
"augroup trailing_whitespace
    "autocmd!
    "autocmd FileType c,cpp,javascript,python,rust,xml,yml,perl,sql,sh autocmd BufWritePre <buffer> :call StripTrailingWhitespace()
"augroup END

" Don't interrupt v-mode due indent
vnoremap < <gv
vnoremap > >gv

" Command flubs
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Cscope
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

function! CscopeQuery(option)
  call inputsave()
  if a:option == '0'
    let query = input('Assignments to: ')
  elseif a:option == '1'
    let query = input('Functions calling: ')
  elseif a:option == '2'
    let query = input('Functions called by: ')
  elseif a:option == '3'
    let query = input('Egrep: ')
  elseif a:option == '4'
    let query = input('File: ')
  elseif a:option == '6'
    let query = input('Definition: ')
  elseif a:option == '7'
    let query = input('Files #including: ')
  elseif a:option == '8'
    let query = input('C Symbol: ')
  elseif a:option == '9'
    let query = input('Text: ')
  else
    echo "Invalid option!"
    return
  endif
  call inputrestore()
  if query != ""
    call Cscope(a:option, query)
  else
    echom "Cancelled Search!"
  endif
endfunction

nnoremap <silent> <Leader>ce :call Cscope('3', expand('<cword>'))<CR>
