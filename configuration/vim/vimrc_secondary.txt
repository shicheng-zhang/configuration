" =========================
" Core Vim Behavior
" =========================

call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

call plug#end()

nnoremap <C-Space> :call VSCodeNotify('editor.action.triggerSuggest')<CR>
inoremap <C-Space> <Cmd>call VSCodeNotify('editor.action.triggerSuggest')<CR>
inoremap <Tab> <Cmd>call VSCodeNotify('acceptSelectedSuggestion')<CR>
inoremap <C-j> <Cmd>call VSCodeNotify('selectNextSuggestion')<CR>
inoremap <C-k> <Cmd>call VSCodeNotify('selectPrevSuggestion')<CR>
nnoremap <leader>. :call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap gd :call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap <leader>r :call VSCodeNotify('editor.action.rename')<CR>
nnoremap <leader>f :call VSCodeNotify('editor.action.formatDocument')<CR>

set completeopt=menu,menuone,noselect
set shortmess+=c

inoremap <C-Space> <C-x><C-o>

set nocompatible
set encoding=utf-8

let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 2

" Use system clipboard (VS Code already does this, but safe)
set clipboard=unnamedplus

" Copy visual selection to Windows clipboard
vnoremap <C-c> :w !clip.exe<CR><CR>

" Paste Windows clipboard
nnoremap <C-v> :r !powershell.exe -command Get-Clipboard<CR>
inoremap <C-v> <Esc>:r !powershell.exe -command Get-Clipboard<CR>i

let g:clipboard = {
\   'name': 'WslClipboard',
\   'copy': {
\      '+': '/mnt/c/Windows/System32/clip.exe',
\      '*': '/mnt/c/Windows/System32/clip.exe',
\    },
\   'paste': {
\      '+': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command Get-Clipboard',
\      '*': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command Get-Clipboard',
\   },
\   'cache_enabled': 0,
\ }

" Better backspace behavior
set backspace=indent,eol,start

" =========================
" UI / Visuals (VS Code鈥搃sh)
" =========================
set number
set relativenumber

set cursorline
set signcolumn=yes

set nowrap
set scrolloff=5
set sidescrolloff=5

set termguicolors
set background=dark

" =========================
" Indentation (VS Code-like)
" =========================
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

" =========================
" Search Behavior
" =========================
set incsearch
set hlsearch
set ignorecase
set smartcase

nnoremap <Esc> :nohlsearch<CR>

" =========================
" Faster / Smoother
" =========================
set updatetime=300
set timeoutlen=500

" =========================
" VS Code Friendly Keybinds
" =========================

" Save like Ctrl+S
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Undo / Redo feel natural
nnoremap U <C-r>

" Better line movement
nnoremap J mzJ`z

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" =========================
" Window / Pane Navigation
" =========================
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" =========================
" Quality-of-Life
" =========================

" Yank to end of line like VS Code
nnoremap Y y$

" Make x not yank
nnoremap x "_x

" =========================
" VSCodeVim Specific
" =========================
if exists('g:vscode')
  " Let VS Code handle tabs, files, etc.
  set noshowmode
endif

