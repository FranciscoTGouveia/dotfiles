return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    vim.keymap.set("n", "<leader>t", ":ToggleTerm direction='float'<CR>")
}
