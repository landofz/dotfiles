local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- tree-sitter based highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- popup displaying possible key bindings
  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {}
    end
  }

  use "lukas-reineke/indent-blankline.nvim" -- show indentation guides
  use 'numToStr/Comment.nvim'               -- commenting support
  -- Plugins
  use 'tmux-plugins/vim-tmux-focus-events' -- FocusGained and FocusLost autocommand events in terminal
  use 'scrooloose/nerdtree'                -- a tree explorer plugin
  use 'Xuyuanp/nerdtree-git-plugin'        -- a plugin for NERDTree showing git status
  use 'junegunn/fzf'                       -- fzf installation
  use 'junegunn/fzf.vim'                   -- use fzf in vim
  use 'mbbill/undotree'                    -- undo history visualizer
  --use 'scrooloose/nerdcommenter'           -- commenting support
  use 'tpope/vim-fugitive'                 -- git wrapper
  use 'tpope/vim-repeat'                   -- repeat plugin maps with '.'
  use 'tpope/vim-surround'                 -- surrounding made easier
  use 'tpope/vim-eunuch'                   -- helpers for unix
  use 'tpope/vim-unimpaired'               -- handy bracket mappings
  use 'gregsexton/gitv'                    -- a repository viewer similar to gitk
  use 'wellle/targets.vim'                 -- additional text objects like , . : =
  use 'michaeljsmith/vim-indent-object'    -- text object based on indentation level
  use 'rhysd/clever-f.vim'                 -- better repeat and marks for f and t mappings
  use 'easymotion/vim-easymotion'          -- simpler way to use motions
  use 'geoffharcourt/vim-matchit'          -- extended '%' matchings
  use 'gerw/vim-HiLinkTrace'               -- trace syntax highlight

  -- Snippets
  --Plugin 'SirVer/ultisnips'
  --"Plugin 'honza/vim-snippets'
  --Plugin 'Shougo/deoplete.nvim'

  use 'fatih/vim-go'                       -- Go development
  use 'isRuslan/vim-es6'                   -- JavaScript snippets
  use 'mattn/emmet-vim'                    -- HTML and CSS high speed coding
  use 'plasticboy/vim-markdown'            -- markdown mode

  use 'ervandew/supertab'                  -- perform all insert mode completions with Tab
  use 'vim-airline/vim-airline'            -- status/tabline
  use 'airblade/vim-gitgutter'             -- shows a git diff in the gutter
  use 'mhinz/vim-grepper'                  -- asynchronous search
  use 'ludovicchabant/vim-gutentags'       -- manages tag files
  use 'majutsushi/tagbar'                  -- displays tags in a window, ordered by scope

  -- Colorschemes
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim'
  use 'drewtempelmeyer/palenight.vim'
  use 'KeitaNakamura/neodark.vim'
  use 'altercation/vim-colors-solarized'
  use 'lisposter/vim-blackboard'
  use 'vim-scripts/xoria256.vim'
  use 'wgibbs/vim-irblack'
  use 'sjl/badwolf'
  use 'tomasr/molokai'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
