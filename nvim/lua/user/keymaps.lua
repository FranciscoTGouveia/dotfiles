local options = { noremap = true, silent = true } -- Create a table to reuse code
local keymap = vim.api.nvim_set_keymap -- Create a local variable to reuse code


-- Normal Mode
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)
keymap("n", "<C-l>", "<C-w>l", options)
