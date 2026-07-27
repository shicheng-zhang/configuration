" ============================================================================
" 1. PLUGINS (Uses vim-plug)
" ============================================================================
call plug#begin('~/.vim/plugged')

" The LSP and Autocomplete engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" A lightweight, clean color scheme
Plug 'joshdick/onedark.vim'

" Status line at the bottom
Plug 'vim-airline/vim-airline'

call plug#end()

" ============================================================================
" 2. BASIC QUALITY OF LIFE SETTINGS
" ============================================================================
syntax on
colorscheme onedark

set number          " Show line numbers
set relativenumber  " Hybrid line numbers for easier jumping
set hidden          " Allow switching buffers without saving
set mouse=a         " Enable mouse support
set signcolumn=yes  " Always show the sign column to prevent text shifting

" Tab & Indent settings (Standard for Java/C++)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set backspace=indent,eol,start

" ============================================================================
" 3. LSP & KEYMAPPINGS (coc.nvim)
" ============================================================================

" Use Tab for trigger completion and navigate next complete item
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> (Enter) to accept selected completion item
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <rn> <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
