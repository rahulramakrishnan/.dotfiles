" Rahul Ramakrishnan Vim RC

" --------------- Vim Plugin Management - Vundle -------------
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " let vundle manage vundle
Plugin 'vim-scripts/indentpython.vim'  " python auto indentation
Plugin 'jnurmine/Zenburn'         " low contrast colorscheme
Plugin 'scrooloose/nerdtree'      " file explorer
Plugin 'jistr/vim-nerdtree-tabs'  " Nerdtree Tabs
Plugin 'tpope/vim-fugitive'       " git integration
Plugin 'kien/ctrlp.vim'           " fuzzy file explorer
Plugin 'vim-airline/vim-airline'  " status line
Plugin 'majutsushi/tagbar'        " class outline viewer
Plugin 'bitc/vim-bad-whitespace'  " highlight bad whitespace
" Plugin 'scrooloose/syntastic'   " syntax checker
" Plugin 'nvie/vim-flake8'        " PEP-8 checker
" Plugin 'tpope/vim-surround'     " quoting and parenthesis
" Plugin 'Valloric/YouCompleteMe' " auto complete
" Plugin 'jiangmiao/auto-pairs'   " auto close parenthesis
" Plugin 'vim-auto-save'          " Auto save
call vundle#end()
filetype plugin on


" ---------------------- Colors ------------------------------
syntax enable
" colorscheme zenburn
" set background=dark
" colorscheme solarized


" ---------------------- Spaces & Tabs -----------------------
set noeb vb t_vb= " Disable Beeps
" python spacing
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=85 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
" flag unnecessary whitespace
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" utf-8
set encoding=utf-8


" ---------------------- UI & Config--------------------------
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


" ---------------------- Searching --------------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" ---------------------- Movement & Splits ------------------
" more natural split opening
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>  " vim split movement
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"Swap top/bottom or left/right split with Ctrl+W R
"Remove dash in vim split
:set fillchars+=vert:\ 

" ---------------------- Plugin Customization ---------------

" Tagbar
nmap <C-o> :TagbarToggle<CR>

" Nerd Tree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore pyc files in NERDTree

" Ctrl P
set runtimepath^=~/.vim/bundle/ctrlp.vim   " Add ctrp to vim path
set wildignore+=*/tmp/*,*/env/*,*.so,*.swp,*.zip,*.pyc,*.unison
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']  " Ignore files in gitignore

" Auto Save
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_silent = 1  " do not display the auto-save notification
" let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option

" Airline
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'

" Python w/ VirtualEnv Support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Make Python Look Pretty
let python_highlight_all=1
syntax on

" System Clipboard
set clipboard=unnamed
" No Swap Files
set noswapfile
