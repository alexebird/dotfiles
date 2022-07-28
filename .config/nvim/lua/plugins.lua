-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- references:
-- - https://github.com/NvChad/NvChad
-- - https://github.com/kabinspace/AstroVim
-- - https://github.com/LunarVim/LunarVim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

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
      'nvim-lua/plenary.nvim' -- library of lua functions
    },
    -- tag = 'release' -- To use the latest release
  }

  -- search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use 'jremmen/vim-ripgrep'

  -- colorschemes
  use 'rebelot/kanagawa.nvim'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  -- fixes
  use 'antoinemadec/FixCursorHold.nvim'
  -- - fix neovim CursorHold and CursorHoldI autocmd events performance bug
  -- - decouple updatetime from CursorHold and CursorHoldI (works for Vim and Neovim)

  use 'tpope/vim-sleuth'
  use 'windwp/nvim-autopairs'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'norcalli/nvim-colorizer.lua' -- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit. (ie, highlight #FFFFFF with white background)
  -- use 'karb94/neoscroll.nvim'
  use 'bronson/vim-trailing-whitespace'
  use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag

  -- easymotion (ie hop)
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
  }

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  --
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'p00f/nvim-ts-rainbow'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- sets comment plugin lang based on language under the cursor

  -- langs

  use 'hashivim/vim-terraform'
  use 'ekalinin/Dockerfile.vim'
  use 'pangloss/vim-javascript'
  use 'MaxMEllon/vim-jsx-pretty'
  -- use {
  --   'cuducos/yaml.nvim',
  --   ft = {'yaml'}, -- optional
  --   requires = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-telescope/telescope.nvim' -- optional
  --   },
  --   config = function ()
  --     require("config.yaml")
  --   end,
  -- }

  use 'sbdchd/neoformat'

  -- language servers
  -- use 'neovim/nvim-lspconfig' -- Quickstart configurations for the Nvim LSP client.
  -- use 'williamboman/nvim-lsp-installer' -- Neovim plugin that allows you to seamlessly install LSP servers locally.
  use {
    'williamboman/nvim-lsp-installer',
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('nvim-lsp-installer').setup {}
        local lspconfig = require('lspconfig')
        lspconfig.sumneko_lua.setup {}
      end
    }
  }


  -- ^^^DONE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  -- use 'folke/trouble.nvim' -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
  -- use 'tami5/lspsaga.nvim' -- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
  -- use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
  -- use 'simrat39/symbols-outline.nvim' -- A tree like view for symbols in Neovim using the Language Server Protocol.
  -- use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
end)
