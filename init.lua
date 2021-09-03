-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'wakatime/vim-wakatime'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'morhetz/gruvbox'

  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end,
  }

  use 'kyazdani42/nvim-web-devicons'
  use "nvim-lua/plenary.nvim"

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp"
    }
  }

  use {
     "kabouzeid/nvim-lspinstall",
     opt = true,
     setup = function()
       packer_lazy_load("nvim-lspinstall")
       vim.defer_fn(function()
         vim.cmd "silent! e %"
       end, 0)
    end,
  }

  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lspinstall",
    config = function()
      require("plugins.lspconfig")
    end,
  }
  use { "jose-elias-alvarez/null-ls.nvim", requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"} }
  use { "folke/trouble.nvim", requires = {"kyazdani42/nvim-web-devicons" } }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('plugins.gitsigns')
    end
  }

  use "rafamadriz/neon"

  use {
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons', 
      opt = true
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'neon'
        }
      }
    end
  }
end)

vim.o.hidden = true
vim.o.wrap = false
vim.o.encoding = "utf-8"
vim.o.pumheight = 10

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true
vim.opt.undodir = "~/.config/nvim/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme neon]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

vim.api.nvim_set_keymap('n', '<S-h>', ':tabprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':tabnext<CR>', { noremap = true })

require('plugins.completion')
require('plugins.telescope')
require('plugins.trouble')

