local set = vim.opt -- Create a local variable to reuse code

-- Indentation Options
set.autoindent = true -- New lines inherit the indentation of previous lines
set.shiftwidth = 4 -- When shifting, indent using four spaces
set.smarttab = true -- Insert tabstop number of spaces when the tab key is pressed
set.tabstop = 4 -- Indent using four spaces
set.smartindent = true --  Make indent smart in C-like programs

-- Search Options
set.hlsearch = true -- Enable search highlightning
set.ignorecase = true -- Ignore case when searching
set.incsearch = true -- Incremental search that shows partial matches
set.smartcase = true -- Automatically switch search to case-sensitive if the query has an uppercase letter


-- Text Rendering Options
set.linebreak = true -- Avoid wrapping a line in the middle of a word
set.scrolloff = 8 -- The number of screen lines to keep aboce and below of the cursor
set.sidescrolloff = 8 -- The number of columns to keep to the left and right of the cursor
set.wrap = false -- Enable line wrapping


-- User Interface Options
set.laststatus = 2 -- Always display the status bar
set.ruler = true -- Always show cursor position
set.wildmenu = true -- Display command line's tab completion options as a menu
set.tabpagemax = 10 -- Maximum number of tab pages that can be opened from the command line 
set.number = true -- Show the line numbers on the sidebar
set.relativenumber = false -- Show line number on the current line and relative numbers on all other lines
set.visualbell = true -- Flash the screen on errors
set.mouse = 'a' -- Enable mouse scrolling (and possible resizing) for all modes 
set.clipboard = "unnamedplus" -- Allows access to the system clipboard
set.pumheight  = 10 -- Pop up menu's height


-- Code Folding Options
set.foldmethod = 'manual' -- "Fold based on indentation levels


-- Miscellaneous Options
set.backspace = 'indent,eol,start' -- Allow backspacing ovre indentation linebreaks and insertion start
set.backup = false -- Doesn't allow backup files to be created
set.confirm = true -- Display a confirmation dialog when writing and quitting
set.hidden = true -- Hide files in the background instead of closing them
set.history = 1000 -- Set the undo limit to 1000
set.timeoutlen = 500 -- Time to wait for a mapped sequence to complete
