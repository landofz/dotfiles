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
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'sjl/gundo.vim'
Plugin 'mbbill/undotree'
"Plugin 'msanders/snipmate.vim'
"Plugin 'edsono/vim-matchit'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'wellle/targets.vim'              " additional text objects like , . : =
Plugin 'michaeljsmith/vim-indent-object' " text object based on indentation level
Plugin 'rhysd/clever-f.vim'              " better repeat and marks for f and t mappings

Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-reload'
Plugin 'landofz/focus.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
"Plugin 'vimwiki/vimwiki'
Plugin 'vim-voom/voom'

Plugin 'fatih/vim-go'
Plugin 'isRuslan/vim-es6'
Plugin 'ervandew/supertab'
"Plugin 'powerline/powerline'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
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
set incsearch
set hlsearch
set ignorecase
set smartcase
set grepprg=ag

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

" Invoking plugins
nnoremap <leader>p :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Ag<space>
nnoremap <leader>/ :Unite grep:.<cr>
nnoremap <leader>s :Unite -quick-match buffer<cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>g :UndotreeToggle<CR>

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

" Show tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

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

" CtrlP
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|build|vendor)$',
    \ 'file': '\v\.pyc$',
    \ }

" Wiki
let g:vimwiki_list = [{
    \ 'path': '~/storage/Notebook/',
    \ 'syntax': 'markdown',
    \ 'ext': '.txt',
    \ }]

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
