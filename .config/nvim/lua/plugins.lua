-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- references:
-- - https://github.com/NvChad/NvChad
-- - https://github.com/kabinspace/AstroVim
-- - https://github.com/LunarVim/LunarVim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- startup
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim.

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  -- use 'kyazdani42/nvim-web-devicons'

  -- commenting
  use {
    'numToStr/Comment.nvim',
    -- config = function()
    --     require('Comment').setup()
    -- end
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    -- tag = 'release' -- To use the latest release
  }

  -- search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  -- use 'jremmen/vim-ripgrep'
  
  -- colorschemes
  use 'rebelot/kanagawa.nvim'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  -- use 'mileszs/ack.vim'
  use 'bronson/vim-trailing-whitespace'
  use 'jremmen/vim-ripgrep'

  -- fixes
  use 'antoinemadec/FixCursorHold.nvim'
  -- - fix neovim CursorHold and CursorHoldI autocmd events performance bug
  -- - decouple updatetime from CursorHold and CursorHoldI (works for Vim and Neovim)
  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-nvim-lsp'

  -- ^^^DONE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  -- treesitter
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- language servers
  -- use 'williamboman/nvim-lsp-installer'
  -- use 'neovim/nvim-lspconfig'
  -- use 'tami5/lspsaga.nvim'
  -- use 'jose-elias-alvarez/null-ls.nvim'

  -- category: ???

  -- use 'nvim-lua/plenary.nvim' -- library of lua functions
  -- use 'simrat39/symbols-outline.nvim'
  -- use 'ryanoasis/vim-devicons'
  -- use 'p00f/nvim-ts-rainbow'
  -- use 'glepnir/dashboard-nvim'
  -- use 'norcalli/nvim-colorizer.lua'
  -- use 'windwp/nvim-autopairs'
  -- use 'lukas-reineke/indent-blankline.nvim'
  -- use 'karb94/neoscroll.nvim'
  -- use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag
end)
