" Rahul Ramakrishnan Vim RC

" --------------- Vim Plugin Management - Vundle -------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

" Plugin 'VundleVim/Vundle.vim' " let vundle manage vundle
" Plugin 'scrooloose/nerdtree'  " file explorer
" Plugin 'tpope/vim-fugitive'   " git integration
" Plugin 'scrooloose/syntastic' " syntax checker
" Plugin 'kien/ctrlp.vim'       " fuzzy file explorer
" Plugin 'bling/vim-airline'    " status line
" Plugin 'tpope/vim-surround'   " quoting and parenthesis
" Plugin 'majutsushi/tagbar'    " class outline viewer
" Plugin 'Valloric/YouCompleteMe'  " auto complete
" Plugin 'altercation/vim-colors-solarized'  " solarized colorscheme
" Plugin 'tomasr/molokai'       " Molokai colortheme
" Plugin 'jiangmiao/auto-pairs' " auto close parenthesis
" Plugin 'vim-auto-save'        " Auto save
" Plugin 'vim-javascript'       " javascript syntax helper

" call vundle#end()
filetype plugin indent on


" ---------------------- Colors ------------------------------
syntax enable
" set background=dark
" colorscheme smyck
" colorscheme solarized


" ---------------------- Spaces & Tabs -----------------------
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set noeb vb t_vb= " Disable Beeps
" python spacing
autocmd BufEnter *.py set tabstop=4
autocmd BufEnter *.py set softtabstop=4
autocmd BufEnter *.py set shiftwidth=4
autocmd BufEnter *.py set textwidth=79
autocmd BufEnter *.py set expandtab
autocmd BufEnter *.py set autoindent
autocmd BufEnter *.py set fileformat=unix

" javascript
autocmd BufEnter *.py setlocal tabstop=2
autocmd BufEnter *.py setlocal softtabstop=2
autocmd BufEnter *.py setlocal shiftwidth=2

" ---------------------- UI & Config--------------------------
set number          " show line numbers
set showcmd         " show command in bottom bar
" set cursorline      " highlight current line
filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to.
set showmatch       " highlight matching [{()}]


" ---------------------- Searching --------------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" ---------------------- Movement ---------------------------
nnoremap <C-J> <C-W><C-J>  " vim split movement
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Swap top/bottom or left/right split
"Ctrl+W R

" more natural split opening
set splitbelow
set splitright


" ---------------------- Plugin Customization ---------------

" Tagbar
nmap <C-o> :TagbarToggle<CR>

" Nerd Tree
map <C-n> :NERDTreeToggle<CR>

" Ctrl P
set runtimepath^=~/.vim/bundle/ctrlp.vim   " Add ctrp to vim path
set wildignore+=*/tmp/*,*.so,*.swp,*.zip   " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f' " MacOSX/Linux
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']  " Ignore files in gitignore

" Auto Save
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_silent = 1  " do not display the auto-save notification
" let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option

" Syntastic
" use jshint
" let g:syntastic_javascript_checkers = ['jshint']
" show any linting errors immediately
" let g:syntastic_check_on_open = 1
