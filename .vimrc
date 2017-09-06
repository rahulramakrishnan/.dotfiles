" ---- general ui ----
set number          " show line numbers
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
hi cursorline cterm=none term=none
" only show cursorline in current buffer
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to.
set showmatch       " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR>


" ---- movement & splits ----
" more natural split opening
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>  " vim split movement
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
