return {
    {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls","arduino_language_server","clangd", "marksman", "pyright", "sqlls", "tsserver"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
            vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {})
        end
    }
}
