vim.g.mapleader = " "

local key = vim.keymap

-- Windows --
key.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
key.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
key.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
key.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })
-- ------- --



key.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk"})
key.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

