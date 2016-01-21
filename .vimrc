" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

" map a leader key
let mapleader=","

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
" set clipboard=unnamed

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

" Fix arrow keys and mouse scroll from inserting characters
map <Esc>[B <Down>

" Show vertical ruler at 100th column
set colorcolumn=100

" Easier navigation between tabs
nmap <C-]> gt
nmap <C-[> gT
" nmap t gt
" nmap T gT

" Easier way to move lines
if has('mac')
  nnoremap ∆ :m+<CR>==
  nnoremap ˚ :m-2<CR>==
  inoremap ∆ <Esc>:m+<CR>==gi
  inoremap ˚ <Esc>:m-2<CR>==gi
  vnoremap ∆ :m'>+<CR>gv=gv
  vnoremap ˚ :m-2<CR>gv=gv
else
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv
endif

" reply macro
nnoremap Q @q

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
filetype on

" Color Scheme
colorscheme my-distinguished

" Syntastic options
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_html_tidy_ignore_errors = ['trimming empty <span>', 'trimming empty <i>', ' is not recognized!', 'discarding unexpected ']

" l20n file syntax hack
autocmd BufNewFile,BufRead *.l20n set syntax=html

" treat .webapp like .json
autocmd BufNewFile,BufRead *.webapp set filetype=json

" treat .jsm like .js
autocmd BufNewFile,BufRead *.jsm set filetype=javascript

" Turn off line wrapping
" set nowrap

" Highlight current line
" set cursorline

" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set list

" ------------------------------------------------------------------------------
" Tabs vs. Spaces
" ------------------------------------------------------------------------------

" Spaces instead of tabs
set expandtab

" X spaces for each tab
set tabstop=2

" X spaces for indention
set shiftwidth=2

" ------------------------------------------------------------------------------
" airline
" ------------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
silent! nmap <c-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ------------------------------------------------------------------------------
" ctrlp
" ------------------------------------------------------------------------------
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
nnoremap <c-b> :CtrlPBuffer<CR>

" ------------------------------------------------------------------------------
" Mark Down
" ------------------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1

" ------------------------------------------------------------------------------
" Gist
" ------------------------------------------------------------------------------
let g:gist_post_private = 1
