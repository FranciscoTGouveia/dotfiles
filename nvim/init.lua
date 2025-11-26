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
  -- LSP support
  { "neovim/nvim-lspconfig" },
  -- Rust support
  { "simrat39/rust-tools.nvim" },
  -- Autocompletion and LSP plugins
  {'hrsh7th/nvim-cmp'},  -- Autocompletion plugin
  {'hrsh7th/cmp-buffer'},  -- Buffer source for nvim-cmp
  {'hrsh7th/cmp-path'},  -- LSP source for nvim-cmp
  {'hrsh7th/cmp-nvim-lsp'},  -- LSP source for nvim-cmp
  {'neovim/nvim-lspconfig'},  -- LSP configuration
  {'onsails/lspkind.nvim'}, -- Adds icons to nvim-cmp
  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  -- Formatting
  { "stevearc/conform.nvim" },
  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- Git signs
  { "lewis6991/gitsigns.nvim" },
  -- Lazygit floating window integration
  { "kdheepak/lazygit.nvim" },
  -- Colorscheme
  { "rebelot/kanagawa.nvim" },
  -- Status line
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

-- ============================
--  Treesitter
-- ============================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "lua", "vim", "vimdoc", "json" },
  highlight = { enable = true },
})

-- ============================
--  LSP: Rust Analyzer
-- ============================
local lspconfig = require("lspconfig")
local rust_tools = require("rust-tools")

rust_tools.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Keybinds for LSP
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
      },
    },
  }
})

-- ============================
--  Auto-format on save
--  (rustfmt automatically)
-- ============================
require("conform").setup({
  formatters_by_ft = {
    rust = { "rustfmt" },
  },
  format_on_save = { timeout_ms = 500 },
})

-- ============================
--  Gitsigns
-- ============================
require("gitsigns").setup()

-- ============================
--  Telescope keybinds
-- ============================
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- ============================
--  Lazygit keybind
-- ============================
vim.keymap.set("n", "<leader>lg", function()
  vim.cmd("LazyGit")
end)

-- ============================
--  Quality of Life Keymaps
-- ============================
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")     -- Save
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")     -- Quit
vim.keymap.set("n", "<leader>e", "<cmd>Ex<cr>")    -- File explorer

