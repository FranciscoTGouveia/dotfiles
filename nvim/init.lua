-- ====================
--  Basic Neovim Setup
-- ====================
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- use spaces instead of tabs for identation


-- =====================
--  Lazy plugin manager
-- =====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================
--  Plugins
-- ============================
require("lazy").setup({
  { "neovim/nvim-lspconfig" },
  {'hrsh7th/nvim-cmp'},  -- Autocompletion plugin
  {'hrsh7th/cmp-buffer'},  -- Buffer source for nvim-cmp
  {'hrsh7th/cmp-path'},  -- LSP source for nvim-cmp
  {'hrsh7th/cmp-nvim-lsp'},  -- LSP source for nvim-cmp
  {'neovim/nvim-lspconfig'},  -- LSP configuration
  {'onsails/lspkind.nvim'}, -- Adds icons to nvim-cmp
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  { "stevearc/conform.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "lewis6991/gitsigns.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "folke/which-key.nvim", config = function() 
    require("which-key").setup({}) 
    end
  },
  {'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup({
          options = { theme = 'tomorrow_night', icons_enabled = true } })
      end
  },

  defaults = { lazy = false },
  ui = { border = 'rounded' }
})

-- =============
--  Colorscheme
-- =============
vim.cmd("colorscheme kanagawa-dragon")
vim.o.background = "dark"
local is_dark = true
local function setup_lualine(theme)
  require('lualine').setup({
    options = {
      theme = theme,
      icons_enabled = true
    }
  })
end
local function toggle_theme()
  if is_dark then
    vim.o.background = "light"
    vim.cmd("colorscheme kanagawa-lotus")
    setup_lualine("Tomorrow")
    is_dark = false
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme kanagawa-dragon")
    setup_lualine("tomorrow_night")
    is_dark = true
  end
end



-- ============================
--  Gitsigns
-- ============================
require("gitsigns").setup()

-- ============================
--  Keybindings
-- ============================
local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>e", "<cmd>Ex<cr>")
map("n", "<leader>tt", toggle_theme)

local wk = require("which-key")
wk.register({
  f = {
    name = "Find",
    f = "Find Files",
    g = "Find Word",
    b = "Find Buffer"
  },
  w = "Save File",
  q = "Quit",
}, { prefix = "<leader>" })
