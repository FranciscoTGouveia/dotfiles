return {
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 }),
        },
      })
    end,
  },

  -- Available for future non-Rust LSPs (e.g. lua_ls, pyright)
  { "neovim/nvim-lspconfig" },

  { "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    init = function()
      -- Using a function so cmp_nvim_lsp is evaluated after all plugins load
      vim.g.rustaceanvim = function()
        return {
          server = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          },
        }
      end
    end,
  },
}
