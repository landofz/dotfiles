local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print 'Installing packer, close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that syncs plugins whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- popup displaying possible key bindings
  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {}
    end
  }

  use "lukas-reineke/indent-blankline.nvim" -- show indentation guides
  use 'numToStr/Comment.nvim'               -- commenting support
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- git info in the signs column

  -- fuzzy finder
  use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'} } -- generic picker
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- lsp
  use 'neovim/nvim-lspconfig' -- collection of configurations for built-in LSP client
  use "williamboman/nvim-lsp-installer" -- language server installer
  use 'simrat39/symbols-outline.nvim' -- display symbols using LSP
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "antoinemadec/FixCursorHold.nvim"

  -- completions
  use 'hrsh7th/nvim-cmp' -- autocompletion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua' -- neovim Lua API
  use 'saadparwaiz1/cmp_luasnip' -- snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- snippets plugin
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Plugins
  use 'scrooloose/nerdtree'                -- a tree explorer plugin
  use 'Xuyuanp/nerdtree-git-plugin'        -- a plugin for NERDTree showing git status
  use 'mbbill/undotree'                    -- undo history visualizer
  use 'tpope/vim-fugitive'                 -- git wrapper
  use 'tpope/vim-repeat'                   -- repeat plugin maps with '.'
  use 'tpope/vim-surround'                 -- surrounding made easier
  use 'tpope/vim-eunuch'                   -- helpers for unix
  use 'tpope/vim-unimpaired'               -- handy bracket mappings
  use 'wellle/targets.vim'                 -- additional text objects like , . : =
  use 'michaeljsmith/vim-indent-object'    -- text object based on indentation level
  use 'rhysd/clever-f.vim'                 -- better repeat and marks for f and t mappings
  use 'easymotion/vim-easymotion'          -- simpler way to use motions
  use 'geoffharcourt/vim-matchit'          -- extended '%' matchings
  use 'gerw/vim-HiLinkTrace'               -- trace syntax highlight

  use 'fatih/vim-go'                       -- Go development
  use 'isRuslan/vim-es6'                   -- JavaScript snippets
  use 'mattn/emmet-vim'                    -- HTML and CSS high speed coding
  use 'plasticboy/vim-markdown'            -- markdown mode

  use 'vim-airline/vim-airline'            -- status/tabline
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
