" For installing vundle use:
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Plugins
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-reload'
Bundle 'landofz/focus.vim'
" Colorschemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/blackboard.vim'
Bundle 'vim-scripts/phd'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'wgibbs/vim-irblack'

filetype plugin indent on

" Security
set modelines=0

" Tabs/spaces
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

" General
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set number
set ruler
set guioptions-=T
set guioptions-=m
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

" Invoking plugins
nnoremap <leader>cp :CtrlP<cr>
nmap <leader>fm <Plug>FocusModeToggle

" Movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Appearance
syntax on
colorscheme blackboard
if has("gui_macvim")
  set guifont=Menlo\ Regular:h16
elseif has("gui_running")
  set guifont=Monospace\ 14
endif

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬
