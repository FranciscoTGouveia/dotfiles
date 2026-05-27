local wk = require("which-key")

local is_dark = true
local function setup_lualine(theme)
  require("lualine").setup({
    options = { theme = theme, icons_enabled = true },
  })
end
local function toggle_theme()
  if is_dark then
    vim.o.background = "light"
    vim.cmd("colorscheme kanagawa-lotus")
    setup_lualine("Tomorrow")
    is_dark = false
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme kanagawa-dragon")
    setup_lualine("tomorrow_night")
    is_dark = true
  end
end

wk.add({
  { "<leader>f",   group = "Find" },
  { "<leader>ff",  "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>fg",  "<cmd>Telescope live_grep<cr>",  desc = "Find Word" },
  { "<leader>b",   group = "Buffers" },
  { "<leader>bd",  "<cmd>bdelete<cr>",              desc = "Close Buffer" },
  { "<C-Tab>",     "<cmd>BufferLineCycleNext<cr>",  desc = "Next Buffer" },
  { "<C-S-Tab>",   "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Buffer" },
  { "]t",          "<cmd>BufferLineCycleNext<cr>",  desc = "Next Buffer" },
  { "[t",          "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Buffer" },
  { "<leader>e",   group = "Explorer" },
  { "<leader>ee",  "<cmd>Neotree focus<cr>",        desc = "Open File Explorer" },
  { "<leader>ec",  "<cmd>Neotree close<cr>",        desc = "Close File Explorer" },
  { "<leader>eb",  "<cmd>Neotree buffers<cr>",      desc = "Open Buffer Explorer" },
  { "<leader>t",   toggle_theme,                    desc = "Toggle Theme" },
  { "<leader>w",   "<cmd>w<cr>",                    desc = "Save" },
  { "<leader>q",   "<cmd>q<cr>",                    desc = "Exit" },
  { "<leader>h",   group = "Hunks" },
  { "<leader>hr",  function() require("gitsigns").reset_hunk() end,       desc = "Reset Hunk" },
  { "<leader>hs",  function() require("gitsigns").stage_hunk() end,       desc = "Stage Hunk" },
  { "<leader>hu",  function() require("gitsigns").undo_stage_hunk() end,  desc = "Undo Stage Hunk" },
  { "<leader>hd",  function() require("gitsigns").diffthis() end,         desc = "Diff File" },
  { "<leader>hb",  function() require("gitsigns").blame_line() end,       desc = "Blame Line" },
  { "<leader>hB",  function() require("gitsigns").blame() end,            desc = "Blame File" },
  { "]h",          function() require("gitsigns").next_hunk() end,         desc = "Next Hunk" },
  { "[h",          function() require("gitsigns").prev_hunk() end,         desc = "Prev Hunk" },
  -- Visual mode: operate only on selected lines
  { "<leader>hr",  function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Reset Hunk", mode = "v" },
  { "<leader>hs",  function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Stage Hunk",  mode = "v" },
})

-- LSP keybindings: attached per buffer whenever an LSP connects
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    wk.add({
      { "gd",          "<cmd>lua vim.lsp.buf.definition()<cr>",      desc = "Go to Definition",     buffer = buf },
      { "gr",          "<cmd>Telescope lsp_references<cr>",          desc = "Find References",      buffer = buf },
      { "gi",          "<cmd>lua vim.lsp.buf.implementation()<cr>",  desc = "Go to Implementation", buffer = buf },
      { "K",           "<cmd>lua vim.lsp.buf.hover()<cr>",           desc = "Hover Docs",           buffer = buf },
      { "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<cr>",     desc = "Code Action",          buffer = buf },
      { "<leader>rn",  "<cmd>lua vim.lsp.buf.rename()<cr>",          desc = "Rename Symbol",        buffer = buf },
      { "<leader>d",   "<cmd>lua vim.diagnostic.open_float()<cr>",   desc = "Show Diagnostic",      buffer = buf },
      { "[d",          "<cmd>lua vim.diagnostic.goto_prev()<cr>",    desc = "Prev Diagnostic",      buffer = buf },
      { "]d",          "<cmd>lua vim.diagnostic.goto_next()<cr>",    desc = "Next Diagnostic",      buffer = buf },
    })
  end,
})
