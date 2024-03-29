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
Plugin 'tpope/vim-unimpaired'               " handy bracket mappings
Plugin 'gregsexton/gitv'                    " a repository viewer similar to gitk
Plugin 'wellle/targets.vim'                 " additional text objects like , . : =
Plugin 'michaeljsmith/vim-indent-object'    " text object based on indentation level
Plugin 'rhysd/clever-f.vim'                 " better repeat and marks for f and t mappings
Plugin 'easymotion/vim-easymotion'          " simpler way to use motions
Plugin 'geoffharcourt/vim-matchit'          " extended '%' matchings
Plugin 'gerw/vim-HiLinkTrace'               " trace syntax highlight
" Snippets
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
Plugin 'Shougo/deoplete.nvim'

Plugin 'fatih/vim-go'                       " Go development
Plugin 'isRuslan/vim-es6'                   " JavaScript snippets
Plugin 'mattn/emmet-vim'                    " HTML and CSS high speed coding
Plugin 'plasticboy/vim-markdown'            " markdown mode

Plugin 'ervandew/supertab'                  " perform all insert mode completions with Tab
Plugin 'vim-airline/vim-airline'            " status/tabline
Plugin 'airblade/vim-gitgutter'             " shows a git diff in the gutter
Plugin 'mhinz/vim-grepper'                  " asynchronous search
Plugin 'ludovicchabant/vim-gutentags'       " manages tag files
Plugin 'majutsushi/tagbar'                  " displays tags in a window, ordered by scope

" Colorschemes
Plugin 'morhetz/gruvbox'
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
let g:python_host_prog = "/home/zoran/virtualenv/neovim_py2/bin/python"
let g:python3_host_prog = "/home/zoran/virtualenv/neovim_py3/bin/python"
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:go_gopls_enabled = 0
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
set lazyredraw

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
nnoremap <leader>% :let @" = expand("%")<cr>  " get current filename

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
let g:gutentags_exclude_filetypes = ['vim', 'markdown', 'text', 'config', 'yaml', 'gitcommit', 'gitrebase', 'mail']
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

nnoremap <silent> <Leader>sw :call local#whitespace#stripTrailing()<CR>
nnoremap <silent> <Leader>ce :call local#cscope#do('3', expand('<cword>'))<CR>
" manually fixing syntax highlighting going out of sync
nnoremap <Leader>fh :syntax sync fromstart<CR>

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
