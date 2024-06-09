vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Numbers --
opt.relativenumber = true
opt.number = true
-- ------- --


-- Indentation --
opt.tabstop = 2 	      -- 2 spaces for tabs
opt.shiftwidth = 2	    -- 2 spaces for indent width
opt.expandtab = true	  -- expand tab to spaces
opt.autoindent = true 	-- copy indent from current line when starting a new one
-- ----------- --


-- Search --
opt.ignorecase = true   -- ignore case when searching
opt.smartcase = true    -- if there is mexed case, search becomes case-sensitive
-- ------ --


-- Split Windows --
opt.splitright = true   -- split vertical window to the right
opt.splitbelow = true   -- split horizontal window to the bottom
-- ------------- --


-- Misc --
opt.wrap = false        -- disable wrapping
opt.cursorline = true   -- highlight current line
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
-- ---- --
