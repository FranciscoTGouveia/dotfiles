return {
  { "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },

  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  { "stevearc/conform.nvim" },

  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  { "whonore/Coqtail",
    ft = "coq",
  },
}
