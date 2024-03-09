return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { "lua", "python", "cpp", "c", "java" },
            highlight = { enable = true },
            indente = { enable = true }
        })
    end
}
