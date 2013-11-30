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

" Easier navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ------------------------------------------------------------------------------
" NERDTree 
" ------------------------------------------------------------------------------
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

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
colorscheme distinguished 

" Turn off line wrapping
" set nowrap

" Highlight current line
set cursorline

" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set list

" ------------------------------------------------------------------------------
" Tabs vs. Spaces
" ------------------------------------------------------------------------------

" Spaces instead of tabs
set expandtab

" 2 spaces for each tab
set tabstop=2

" 2 spaces for indention
set shiftwidth=2

" ------------------------------------------------------------------------------
" Unite 
" ------------------------------------------------------------------------------

nmap <space> [unite]
" Pro-tip, from the Unite window hit <C-l> to refresh the cache
" Unite-f for files, Unite-r for recents, Unite-g for grep
nnoremap [unite]f :Unite -no-split -start-insert file_rec/async:!<CR>
nnoremap [unite]r :Unite -no-split buffer file_mru<CR>
nnoremap [unite]g :Unite -no-split grep:.<CR>
nnoremap [unite]o :Unite -no-split outline<CR>

let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden -S -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('source/file_rec/async', 'ignorecase', 1)
call unite#set_profile('source/file_rec/async', 'smartcase', 1)

" Exit with ESC. You must never call :quit from within a unite buffer
function! s:unite_settings()
    imap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <C-j> <Plug>(unite_insert_leave)
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()
