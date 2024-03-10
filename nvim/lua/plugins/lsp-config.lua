return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function ()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {auto_install = true}
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities
            })
            lspconfig.pyright.setup({capabilities = capabilities})
            lspconfig.clangd.setup({capabilities = capabilities})
            lspconfig.jdtls.setup({capabilities = capabilities})
            vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, {})
            vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {})
        end
    }
}
