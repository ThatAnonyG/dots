set nocompatible

" Detect the file type of the current file
filetype on
" Enable plugins and load file type specific plugins
filetype plugin on
" Load indent file for the current file type
filetype indent on
" Enable syntax highlighting
syntax on
" Activate line numbers
set number
" Set tab length
set tabstop=2
" Set indentation size
set shiftwidth=2
" Make tabs use spaces
set expandtab
" Let tabstop insert spaces instead of tabs
set softtabstop=0
" Don't wrap long lines
set nowrap
" Highlight characters as I type in search string
set incsearch
" Show matching words during a search
set showmatch
" Partially match commands while typing
set showcmd
" Show the current active vim mode
set showmode
" Limit scroll limit to N lines
set scrolloff=10
" Do not save backup files
set nobackup
" Highlight search results
set hlsearch
" Set command history
set history=1000
" Set backspace behavior
set backspace=eol,start,indent
" Set cursor behavior
set whichwrap=<,>,h,l,[,]
" Enable auto indentation
set autoindent
" Set encoding
set encoding=utf8
" Remap leader key
let mapleader = " "

" Custom mappings
inoremap jj <esc>
nnoremap <silent> <Leader>h :nohl<CR>

" Screw arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Clear the status line
set statusline=
" Left side view
set statusline+=\ %F\ %M\ %Y\ %R
" Add divider between
set statusline+=%=
" Right side view
set statusline+=row:\ %l\ col:\ %c
" Show the status line at
set laststatus=2

