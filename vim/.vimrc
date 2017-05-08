" For installing vundle use:
"   git clone https://github.com/gmarik/Vundle.vim.git \
"     ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'sjl/gundo.vim'
"Plugin 'msanders/snipmate.vim'
Plugin 'edsono/vim-matchit'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-reload'
Plugin 'landofz/focus.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'

Plugin 'fatih/vim-go'
Plugin 'isRuslan/vim-es6'
Plugin 'ervandew/supertab'
"Plugin 'powerline/powerline'
Plugin 'bling/vim-airline'
Plugin 'rking/ag.vim'
" Colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/blackboard.vim'
Plugin 'vim-scripts/phd'
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
if !has("nvim")
    set encoding=utf-8
endif
set hidden
set scrolloff=3
set showmode
set showcmd
set number
set relativenumber
set ruler
set laststatus=2
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set nobackup
set noswapfile
set visualbell
set noerrorbells
set wildmenu
set showmatch

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Keys
let mapleader = ","
inoremap jj <Esc>

" Editing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" General bindings
nnoremap <leader>w :w<CR>
nnoremap <CR> G
nnoremap <BS> gg
nnoremap <leader>l :b#<cr>

" Invoking plugins
nnoremap <leader>cpp :CtrlP<cr>
nnoremap <leader>cpb :CtrlPBuffer<cr>
nnoremap <leader>cpr :CtrlPClearCache<cr>
nnoremap <leader>/ :Unite grep:.<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>nt :NERDTree<cr>
nmap <leader>fm <Plug>FocusModeToggle
nnoremap <leader>n :NERDTreeToggle<CR>

" Movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Appearance
syntax on
set background=dark
colorscheme blackboard
if has("gui_macvim")
  set guifont=Menlo\ Regular:h16
elseif has("gui_running")
  set guifont=Monospace\ 12
endif
let g:airline_powerline_fonts = 1

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" Filetype specific options
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2

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

" CtrlP
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|build|vendor)$',
    \ 'file': '\v\.pyc$',
    \ }

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
