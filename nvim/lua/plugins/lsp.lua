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
      -- `\name` -> Unicode symbols (lua/unicode_input.lua), Rocq buffers only
      cmp.register_source("unicode", require("unicode_input").cmp_source())
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "unicode", keyword_length = 2 },  -- `\` + 1 char
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

  -- Non-Rust LSPs (Rust is handled by rustaceanvim below).
  -- Servers listed in vim.lsp.enable() pick up their command/root detection
  -- from nvim-lspconfig's bundled configs; the binaries must be on $PATH.
  { "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Applies to every server below, so completion is LSP-aware
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- C/C++. clangd finds includes and flags via compile_commands.json
      -- (CMake: -DCMAKE_EXPORT_COMPILE_COMMANDS=ON, or bear/compiledb for
      -- Makefiles); without one it falls back to a bare `-std` guess and
      -- cross-file jumps will be incomplete.
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
        },
      })
      vim.lsp.enable("clangd")
    end,
  },

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
