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
" fzf
" ------------------------------------------------------------------------------

let g:fzf_layout = { 'up': '30%' }

if isdirectory($HOME . "/.fzf")
    set rtp+=~/.fzf
else
    set rtp+=/usr/local/opt/fzf
endif

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
" ale
" ------------------------------------------------------------------------------

let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" ------------------------------------------------------------------------------
" lightine
" ------------------------------------------------------------------------------

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
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
silent! nmap <c-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ------------------------------------------------------------------------------
" Vdebug
" ------------------------------------------------------------------------------
let g:vdebug_options = {'break_on_open': 0}
