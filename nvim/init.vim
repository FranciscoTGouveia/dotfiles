" Indentation Options
set autoindent "New lines inherit the indentation of previous lines
set shiftwidth=4 "When shifting, indent using four spaces
set smarttab "Insert tabstop number of spaces when the tab key is pressed
set tabstop=4 "Indent using four spaces


" Search Options
set hlsearch "Enable search highlightning
set ignorecase "Ignore case when searching
set incsearch "Incremental search that shows partial matches
set smartcase " Automatically switch search to case-sensitive if the query has an uppercase letter


" Text Rendering Options
set linebreak "Avoid wrapping a line in the middle of a word
set scrolloff=1 "The number of screen lines to keep above and below the cursor
set sidescrolloff=5 "The number of columns to keep to the left and right of the cursor.
syntax enable "Enable syntax highlighting
set wrap "Enable line wrapping


" User Interface Options
set laststatus=2 "Always display the status bar
set ruler "Always show cursor position
set wildmenu "Display command line's tab complete options as a menu
set tabpagemax=10 "Maximum number of tab pages that can be opened from the comand line
set number "Show the line numbers on the sidebar
set relativenumber "Show line number on the current line and relative numbers on all other lines
set visualbell "Flash the screen on erros
set mouse=a "Enable mouse for scrolling (and possible resizing)


" Code Folding Options
set foldmethod=indent "Fold based on indention levels


" Miscellaneous Options
set backspace=indent,eol,start "Allow backspacing over indention linebreaks and insertion start
set backupdir=~/.cache/nvim "Directory to store backup files
set confirm "Display 
set dir=~/.cache/nvim "Directory to store swap files
set hidden "Hide Files in the background instead of closing them
set history=1000 "Increase the undo limit
set noswapfile "Disable swap files
