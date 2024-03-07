vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



local opts = {}

require("lazy").setup("plugins")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>w", builtin.live_grep, {})

vim.keymap.set("n", "<leader>d", ":Neotree<CR>", {})


local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = { "lua", "python", "cpp", "c", "java" },
    highlight = { enable = true },
    indente = { enable = true }
})

require("kanagawa").setup()
vim.cmd.colorscheme "kanagawa-dragon"
require("telescope").setup()
