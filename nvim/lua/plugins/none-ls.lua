return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.sclang_format,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.diagnostics.clang_check,
                null_ls.builtins.diagnostics.cpplint
            }
        })
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
    end
}
