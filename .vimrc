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

" Enhance command-line completion
set wildmenu

" Allow backspace in insert mode
set backspace=indent,eol,start

" Indention
set autoindent

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

" ------------------------------------------------------------------------------
" Searching
" ------------------------------------------------------------------------------

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase
set smartcase

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
colorscheme rizzle

" Syntastic options
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_html_tidy_ignore_errors = ['trimming empty <span>', 'trimming empty <i>', ' is not recognized!', 'discarding unexpected ', 'proprietary attribute']

" ------------------------------------------------------------------------------
" PHP
" ------------------------------------------------------------------------------

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" ------------------------------------------------------------------------------
" Tabs vs. Spaces
" ------------------------------------------------------------------------------

" Spaces instead of tabs
set expandtab

" X spaces for each tab
set tabstop=4

" X spaces for indention
set shiftwidth=4

" ------------------------------------------------------------------------------
" airline
" ------------------------------------------------------------------------------
let g:airline_powerline_fonts = 1

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
    \ 1: ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -v node_modules'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
" use the cmatcher plugin
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
nnoremap <c-b> :CtrlPBuffer<CR>

" ------------------------------------------------------------------------------
" Mark Down
" ------------------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1

" ------------------------------------------------------------------------------
" Vdebug
" ------------------------------------------------------------------------------
let g:vdebug_options = {'break_on_open': 0}
