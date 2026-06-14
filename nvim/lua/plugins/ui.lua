return {
  { "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa-dragon")
      vim.o.background = "dark"
    end,
  },

  { "maxmx03/solarized.nvim",
    lazy = true,
    opts = { theme = "solarized", variant = "spring" },
  },

  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tomorrow_night", icons_enabled = true },
      })
    end,
  },

  { "akinsho/bufferline.nvim", version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          offsets = {
            { filetype = "neo-tree", text = "File Explorer", separator = true },
          },
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      })
    end,
  },

  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default",
        },
        window = { position = "right", width = 30 },
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
      })
    end,
  },
}
