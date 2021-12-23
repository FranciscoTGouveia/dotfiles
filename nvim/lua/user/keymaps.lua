local options = {noremap = true, silent = true} -- Create a table to reuse code
local keymap = vim.api.nvim_set_keymap -- Create a local variable to reuse code

-- Remap space as a leader key
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "


-- Normal Mode
	-- Window navigation
	keymap("n", "<C-h>", "<C-w>h", options)
	keymap("n", "<C-j>", "<C-w>j", options)
	keymap("n", "<C-k>", "<C-w>k", options)
	keymap("n", "<C-l>", "<C-w>l", options)
	
	-- Toggle Left Explorer
	keymap("n", "<leader>e", ":Lexplore 30<Enter>", options)
	
	-- Resize with arrows
	keymap("n", "<C-Up>", ":resize -2<Enter>", options)
	keymap("n", "<C-Down>", ":resize +2<Enter>", options)
	keymap("n", "<C-Left>", ":vertical resize -2<Enter>", options)
	keymap("n", "<C-Right>", ":vertical resize +2<Enter>", options)

	-- Navigate buffers
	keymap("n", "<S-l>", ":bnext<Enter>", options)
	keymap("n", "<S-h>", ":bprevious<Enter>", options)
