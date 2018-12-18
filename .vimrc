" ------------------------------------------------------------------------------
" Plug
" ------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'felixhummel/setcolors.vim'
Plug 'gerw/vim-HiLinkTrace'
Plug 'itchyny/lightline.vim'
Plug 'jedireza/vim-rizzle'
Plug 'junegunn/fzf.vim'
Plug 'maralla/completor.vim'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'ternjs/tern_for_vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-vdebug/vdebug'
Plug 'w0rp/ale'
Plug 'wesQ3/vim-windowswap'

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

" Cursorline
set nocursorline

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
set colorcolumn=0

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

" True colors
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Color Scheme
colorscheme rizzle

" Find the highlight group
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ------------------------------------------------------------------------------
" completor
" ------------------------------------------------------------------------------

" disable auto trigger
let g:completor_auto_trigger = 0

" activate with tab
inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"

" binaries
let g:completor_racer_binary = '/Users/reza/.cargo/bin/racer'
let g:completor_node_binary = '/Users/reza/.nvm/versions/node/v10.9.0/bin/node'

" ------------------------------------------------------------------------------
" LSP
" ------------------------------------------------------------------------------

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

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

let g:ale_set_highlights = 0
let g:ale_completion_enabled = 1
let g:ale_rust_rls_executable = 'rls'
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_linters = {
\    'typescript': ['tslint'],
\}
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

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
silent! nmap <c-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ------------------------------------------------------------------------------
" Vdebug
" ------------------------------------------------------------------------------
let g:vdebug_options = {'break_on_open': 0}