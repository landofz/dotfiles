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
Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
"Plugin 'msanders/snipmate.vim'
Plugin 'edsono/vim-matchit'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-reload'
Plugin 'landofz/focus.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'

Plugin 'ervandew/supertab'
"Plugin 'powerline/powerline'
Plugin 'bling/vim-airline'
" Colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/blackboard.vim'
Plugin 'vim-scripts/phd'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'wgibbs/vim-irblack'

call vundle#end()
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
nnoremap <leader>/ :Unite grep:.<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
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
let g:airline_powerline_fonts = 1

" Use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬
