" ------------------------------------------------------------------------------
" Plug
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'gerw/vim-HiLinkTrace'
Plug 'itchyny/lightline.vim'
Plug 'jbmorgado/vim-pine-script'
Plug 'jelera/vim-javascript-syntax'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'rakr/vim-one'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'ternjs/tern_for_vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
Plug 'ycm-core/YouCompleteMe'
Plug 'easymotion/vim-easymotion'

call plug#end()


" ------------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------------

" Make Vim more useful
set nocompatible

" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile

" Disable folding
set nofoldenable

" Use UTF-8 without BOM
" set encoding=utf-8 nobomb

" Don’t add empty newlines at the end of files
" set binary
" set noeol

" Enhance command-line completion
" set wildmenu

" Allow backspace in insert mode
" set backspace=indent,eol,start

" Indention
set autoindent

" Always show status line
" set laststatus=2

" Don’t reset cursor to start of line when moving around.
" set nostartofline

" Cursorline
" set nocursorline

" Show the filename in the window titlebar
" set title

" Start scrolling three lines before the horizontal window border
" set scrolloff=3

" Easier navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Fix arrow keys and mouse scroll from inserting characters
" map <Esc>[B <Down>

" Show vertical ruler at 100th column
set colorcolumn=0

" ------------------------------------------------------------------------------
" fzf
" ------------------------------------------------------------------------------

let g:fzf_layout = { 'up': '30%' }

if isdirectory($HOME . "/.fzf")
    set rtp+=~/.fzf
else
    set rtp+=/opt/homebrew/opt/fzf
endif

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Rg<CR>

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

" Enable true color
if exists('$TMUX')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

" Enable line numbers
set number

" Enable syntax highlighting
syntax on
filetype on

" Color Scheme
colorscheme one
set background=dark
call one#highlight('Normal', '', '000000', '')

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
" YouCompleteMe
" ------------------------------------------------------------------------------
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_autoclose_preview_window_after_completion = 1

" ------------------------------------------------------------------------------
" ale
" ------------------------------------------------------------------------------

nnoremap <leader>ad :ALEDetail<CR>

let g:ale_set_highlights = 0
let g:ale_completion_enabled = 0
let g:ale_rust_rls_executable = 'rls'
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'graphql': ['prettier'],
\   'html': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'javascriptreact': ['eslint', 'prettier'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'scss': ['prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\}
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" ------------------------------------------------------------------------------
" rust.vim
" ------------------------------------------------------------------------------

let g:rustfmt_autosave = 1
hi rustQuestionMark guifg=#ff9011 guibg=NONE

" ------------------------------------------------------------------------------
" lightine
" ------------------------------------------------------------------------------

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['relativepath', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
silent! nmap <c-p> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ------------------------------------------------------------------------------
" custom file extension <=> syntax mapping
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.pine set filetype=psl

