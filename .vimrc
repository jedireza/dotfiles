" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

" Make Vim more useful
set nocompatible

" Enable pathogen
set nocp
execute pathogen#infect()

" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile

" Disable folding
set nofoldenable

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Don’t add empty newlines at the end of files
set binary
set noeol

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow backspace in insert mode
set backspace=indent,eol,start

" Indention
set autoindent

" Add the g flag to search/replace by default
set gdefault

" Always show status line
set laststatus=2

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the filename in the window titlebar
set title

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" ------------------------------------------------------------------------------
" Searching
" ------------------------------------------------------------------------------

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" ------------------------------------------------------------------------------
" Styling
" ------------------------------------------------------------------------------

" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Color Scheme
colorscheme darkburn

" Turn off line wrapping
set nowrap

" Highlight current line
set cursorline

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" ------------------------------------------------------------------------------
" Tabs vs. Spaces
" ------------------------------------------------------------------------------

" Spaces instead of tabs
set expandtab

" 2 spaces for each tab
set tabstop=2

" 2 spaces for indention
set shiftwidth=2
