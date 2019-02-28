
" Active plugins
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Get theme from pywal"
Plug 'https://github.com/dylanaraps/wal.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Vim settings and mappings


" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4		" Tabs are spaces
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

set number           " Linenumbers
syntax enable        " Syntax highlighting
set showcmd          " Commandline in bottom right"
" set cursorline     " Line where cursor is located
set wildmenu         " Visual autocomplete for command menu
set showmatch        " Highlight matching { } 
set incsearch        " Incremental search, searches as characters are entered
set hlsearch         " Highlights matches in search
syntax on	     " Syntax highlight on
set clipboard=clipit " Sets the clipboard to system clipboard
set smartindent      " 
set shiftwidth=4     "


colorscheme wal


" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
