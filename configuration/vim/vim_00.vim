" ============================================================
"  _   _(_)_ __ ___   ___   __ _  ___   __   _____  ___ ___   _| | ___
" | | | | | '_ ` _ \ / _ \ / _` |/ __|  \ \ / / __|/ __/ _ \ / _` |/ _ \
" | |_| | | | | | | | (_) | (_| | (__    \ V /\__ \ (_| (_) | (_| |  __/
"  \__, |_|_| |_| |_|\___/ \__,_|\___|    \_/ |___/\___\___/ \__,_|\___|
"  |___/
"  Full VSCode-like experience for Vim
" ============================================================

" ─── PREREQUISITES ──────────────────────────────────────────────────────────
"  1. Install vim-plug:
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"  2. Install Node.js (required for coc.nvim):
"     https://nodejs.org  (v16+ recommended)
"
"  3. Install a Nerd Font for icons:
"     https://www.nerdfonts.com  (e.g. JetBrainsMono Nerd Font)
"     Set it as your terminal font.
"
"  4. After dropping this file at ~/.vimrc, open vim and run:
"     :PlugInstall
"
"  5. Then install LSP servers (examples):
"     :CocInstall coc-tsserver coc-pyright coc-json coc-html coc-css
"     :CocInstall coc-rust-analyzer coc-clangd coc-go coc-lua
"     :CocInstall coc-snippets coc-pairs coc-prettier coc-eslint
"
"  6. For GitHub Copilot:
"     :Copilot setup   (requires a Copilot subscription)
" ─────────────────────────────────────────────────────────────────────────────


" ════════════════════════════════════════════════════════════
"  PLUGINS  (vim-plug)
" ════════════════════════════════════════════════════════════
call plug#begin('~/.vim/plugged')

" ── Core / UI ─────────────────────────────────────────────
Plug 'morhetz/gruvbox'                    " Theme (VSCode Dark+–like warmth)
Plug 'vim-airline/vim-airline'            " Statusbar like VSCode bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'            " File-type icons
Plug 'luochen1990/rainbow'               " Rainbow bracket pairs
Plug 'Yggdroot/indentLine'               " Indentation guides (like VSCode)
Plug 'mhinz/vim-startify'               " Start screen with recent files

" ── File Explorer (Sidebar) ───────────────────────────────
Plug 'preservim/nerdtree'               " VSCode-style sidebar explorer
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git status in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Colored icons in NERDTree
Plug 'PhilRunninger/nerdtree-buffer-ops' " Buffer operations in NERDTree

" ── LSP + Autocomplete (the heart of VSCode parity) ───────
" coc.nvim is a Node-based LSP client — essentially VSCode's engine in Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ── AI Code Suggestions ───────────────────────────────────
Plug 'github/copilot.vim'               " GitHub Copilot (requires subscription)
" Alternative: uncomment below for free Codeium AI
" Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

" ── Fuzzy Finder (Cmd+P / Ctrl+P) ────────────────────────
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                 " :Files, :Rg, :Buffers, etc.

" ── Syntax Highlighting ───────────────────────────────────
Plug 'sheerun/vim-polyglot'             " 100+ language syntax packs
Plug 'nvim-treesitter/nvim-treesitter'  " (Neovim only — skip if pure Vim)

" ── Git Integration ───────────────────────────────────────
Plug 'tpope/vim-fugitive'               " Full Git inside Vim
Plug 'airblade/vim-gitgutter'           " Git diff in the gutter (like VSCode)
Plug 'junegunn/gv.vim'                  " Git commit browser

" ── Editing Superpowers ───────────────────────────────────
Plug 'tpope/vim-surround'               " Surround text with brackets/quotes
Plug 'tpope/vim-commentary'             " Toggle comments (Ctrl+/)
Plug 'jiangmiao/auto-pairs'             " Auto-close brackets and quotes
Plug 'mg979/vim-visual-multi'           " Multi-cursor (like Ctrl+D in VSCode)
Plug 'mattn/emmet-vim'                  " Emmet for HTML/CSS
Plug 'AndrewRadev/tagalong.vim'         " Auto-rename HTML tag pairs

" ── Tabs / Buffers ────────────────────────────────────────
Plug 'vim-ctrlspace/vim-ctrlspace'      " Tab and buffer manager
" OR use this lighter tab line:
" Plug 'ap/vim-buftabline'

" ── Terminal ──────────────────────────────────────────────
Plug 'voldikss/vim-floaterm'            " Floating terminal (like VSCode's)

" ── Search & Navigation ───────────────────────────────────
Plug 'easymotion/vim-easymotion'        " Jump anywhere on screen
Plug 'haya14busa/incsearch.vim'         " Better incremental search
Plug 'preservim/tagbar'                 " Code outline / symbol sidebar

" ── Formatting & Linting ──────────────────────────────────
Plug 'dense-analysis/ale'               " Async linting engine (redundant if
"                                         using coc-eslint, but useful backup)

" ── Snippets ──────────────────────────────────────────────
Plug 'honza/vim-snippets'               " Community snippet library for coc-snippets

" ── Markdown / Docs ───────────────────────────────────────
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()


" ════════════════════════════════════════════════════════════
"  BASIC VIM SETTINGS  (things VSCode does automatically)
" ════════════════════════════════════════════════════════════
set nocompatible                        " Ditch Vi compatibility
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Display
set number                              " Line numbers
set relativenumber                      " Relative line numbers
set signcolumn=yes                      " Always show gutter (for LSP/git icons)
set cursorline                          " Highlight current line
set colorcolumn=                        " No column ruler (VSCode doesn't show one by default)
set nowrap                              " No line wrap by default
set showmatch                           " Highlight matching brackets
set scrolloff=8                         " Keep 8 lines above/below cursor
set sidescrolloff=8

" Editing
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                           " Spaces, not tabs
set autoindent
set smartindent
set backspace=indent,eol,start

" Search
set incsearch                           " Live search as you type
set hlsearch                            " Highlight matches
set ignorecase
set smartcase                           " Case-sensitive only if uppercase used

" Performance
set lazyredraw
set updatetime=100                      " Faster CursorHold events (git gutter, etc.)
set timeoutlen=500

" Files
set autoread                            " Auto-reload files changed outside Vim
set hidden                              " Allow switching buffers without saving
set noswapfile
set nobackup
set nowritebackup
set undofile                            " Persistent undo
set undodir=~/.vim/undodir

" Splits (VSCode-like behaviour)
set splitright                          " New vertical splits go right
set splitbelow                          " New horizontal splits go below

" Clipboard (use system clipboard like VSCode)
set clipboard=unnamedplus

" Mouse
set mouse=a                             " Full mouse support

" Wildmenu (better command completion)
set wildmenu
set wildmode=longest:full,full

" ════════════════════════════════════════════════════════════
"  THEME & VISUAL APPEARANCE
" ════════════════════════════════════════════════════════════
set termguicolors                       " True 24-bit color
set background=dark
colorscheme gruvbox

" Transparent background (matches most terminals)
" hi Normal guibg=NONE ctermbg=NONE

" Airline (bottom status bar)
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1       " Requires Nerd Font
let g:airline#extensions#tabline#enabled = 1   " Show open buffers as tabs
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1    " Show Git branch

" ════════════════════════════════════════════════════════════
"  NERDTREE  (File Explorer Sidebar)
" ════════════════════════════════════════════════════════════
let g:NERDTreeShowHidden = 1            " Show dotfiles
let g:NERDTreeMinimalUI = 1             " Clean look
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeIgnore = ['^\.git$', '^node_modules$', '^\.DS_Store$', '\.pyc$']
let g:NERDTreeWinSize = 35

" Auto-open NERDTree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Close Vim if NERDTree is the only window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
    \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Sync NERDTree with current file
function! NERDTreeSyncFile()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction


" ════════════════════════════════════════════════════════════
"  COC.NVIM  (LSP, Autocomplete, Diagnostics — VSCode engine)
" ════════════════════════════════════════════════════════════

" List of recommended extensions — install with :CocInstall <name>
" coc-tsserver    TypeScript / JavaScript
" coc-pyright     Python
" coc-rust-analyzer Rust
" coc-clangd      C / C++
" coc-go          Go
" coc-java        Java (requires JDK)
" coc-lua         Lua
" coc-json        JSON with schema validation
" coc-html        HTML
" coc-css         CSS / SCSS / Less
" coc-snippets    Snippet engine
" coc-pairs       Auto-pairs via LSP
" coc-prettier    Code formatting
" coc-eslint      ESLint integration

" Use Tab / Shift-Tab to navigate autocomplete (like VSCode)
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Confirm completion with Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion manually with Ctrl+Space
inoremap <silent><expr> <c-space> coc#refresh()

" Diagnostics navigation (like F8 / Shift+F8 in VSCode)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go-to actions (like VSCode F12 / Ctrl+click)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Hover documentation (like hovering in VSCode)
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Rename symbol (F2 in VSCode)
nmap <leader>rn <Plug>(coc-rename)

" Format selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Code actions (like Ctrl+. in VSCode — quick fixes)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>as  <Plug>(coc-codeaction-source)
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Diagnostics list (like VSCode Problems panel)
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<CR>

" Show all symbols (like Ctrl+T in VSCode)
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<CR>

" Highlight symbol and its references when cursor holds
autocmd CursorHold * silent call CocActionAsync('highlight')

" Format on save (like VSCode's "Format on Save")
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*.py,*.rs,*.go silent! call CocAction('format')

" Show signature help while typing function arguments
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Floating window scroll
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" ════════════════════════════════════════════════════════════
"  GITHUB COPILOT  (AI Code Suggestions)
" ════════════════════════════════════════════════════════════
" Accept Copilot suggestion with Alt+l (or customize below)
imap <silent><script><expr> <M-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = 1            " Don't let Copilot steal Tab (coc owns it)
let g:copilot_filetypes = {
      \ 'gitcommit': v:true,
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ }

" Copilot cycle suggestions
imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)
imap <M-\> <Plug>(copilot-suggest)


" ════════════════════════════════════════════════════════════
"  FZF  (Fuzzy Finder — Ctrl+P / Command Palette)
" ════════════════════════════════════════════════════════════
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['right,50%', 'ctrl-/']

" Ctrl+P — file finder (like VSCode Ctrl+P)
nnoremap <C-p> :Files<CR>
" Ctrl+Shift+F — search text across project (like VSCode)
nnoremap <C-S-f> :Rg<CR>
" Ctrl+Shift+P — commands
nnoremap <C-S-p> :Commands<CR>
" Ctrl+Tab — switch buffers
nnoremap <C-Tab> :Buffers<CR>
" List open buffers
nnoremap <leader>b :Buffers<CR>
" Search Git files only
nnoremap <leader>gf :GFiles<CR>
" Search lines in current buffer
nnoremap <leader>/ :BLines<CR>
" Search all lines in all open buffers
nnoremap <leader>l :Lines<CR>


" ════════════════════════════════════════════════════════════
"  TAGBAR  (Code Outline / Symbol Sidebar — like VSCode outline)
" ════════════════════════════════════════════════════════════
let g:tagbar_width = 30
let g:tagbar_autoclose = 0


" ════════════════════════════════════════════════════════════
"  GIT INTEGRATION
" ════════════════════════════════════════════════════════════
" vim-gitgutter (gutter signs like VSCode)
let g:gitgutter_sign_added    = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed  = '-'
let g:gitgutter_update_interval = 100

" Fugitive shortcuts
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gv :GV<CR>            " Git log browser


" ════════════════════════════════════════════════════════════
"  FLOATERM  (Integrated Terminal — like VSCode Ctrl+`)
" ════════════════════════════════════════════════════════════
let g:floaterm_width = 0.85
let g:floaterm_height = 0.35
let g:floaterm_position = 'bottom'
let g:floaterm_autoclose = 1

nnoremap <silent> <C-`> :FloatermToggle<CR>
tnoremap <silent> <C-`> <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <leader>t :FloatermNew<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermNew<CR>


" ════════════════════════════════════════════════════════════
"  INDENT GUIDES  (like VSCode's indent lines)
" ════════════════════════════════════════════════════════════
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_gui = '#3c3836'


" ════════════════════════════════════════════════════════════
"  RAINBOW BRACKETS
" ════════════════════════════════════════════════════════════
let g:rainbow_active = 1


" ════════════════════════════════════════════════════════════
"  MULTI-CURSOR  (like Ctrl+D in VSCode)
" ════════════════════════════════════════════════════════════
" Ctrl+D to select next occurrence (same as VSCode)
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Select All']         = '<C-M-l>'    " Select all occurrences


" ════════════════════════════════════════════════════════════
"  EASYMOTION  (keyboard-first navigation)
" ════════════════════════════════════════════════════════════
let g:EasyMotion_do_mapping = 0         " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)    " Jump to any 2-char pattern with s
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" ════════════════════════════════════════════════════════════
"  ALE  (Linting)
" ════════════════════════════════════════════════════════════
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 0              " Use coc-prettier for formatting instead
" Disable ALE for LSP languages managed by coc (avoid duplication)
let g:ale_linters_ignore = {
      \ 'typescript': ['tsserver'],
      \ 'javascript': ['tsserver'],
      \ 'python':     ['pyls', 'pylsp'],
      \ }


" ════════════════════════════════════════════════════════════
"  STARTIFY  (Start Screen)
" ════════════════════════════════════════════════════════════
let g:startify_custom_header = [
      \ '                                                     ',
      \ '       ██╗   ██╗██╗███╗   ███╗                      ',
      \ '       ██║   ██║██║████╗ ████║                      ',
      \ '       ██║   ██║██║██╔████╔██║                      ',
      \ '       ╚██╗ ██╔╝██║██║╚██╔╝██║                      ',
      \ '        ╚████╔╝ ██║██║ ╚═╝ ██║                      ',
      \ '         ╚═══╝  ╚═╝╚═╝     ╚═╝                      ',
      \ ]
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recent Files']   },
      \ { 'type': 'dir',       'header': ['   Current Dir: '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']        },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']       },
      \ ]


" ════════════════════════════════════════════════════════════
"  KEY MAPPINGS  (VSCode muscle-memory)
" ════════════════════════════════════════════════════════════
let mapleader = " "                     " Space as leader (common modern choice)

" ── File Explorer ─────────────────────────────────────────
nnoremap <C-b> :NERDTreeToggle<CR>      " Ctrl+B  like VSCode
nnoremap <leader>e :NERDTreeFind<CR>    " Reveal current file in tree

" ── Outline sidebar ───────────────────────────────────────
nnoremap <leader>o :TagbarToggle<CR>

" ── Splitting (like VSCode Ctrl+\ and Ctrl+1/2) ───────────
nnoremap <leader>\ :vsplit<CR>
nnoremap <leader>- :split<CR>

" ── Window navigation (Alt+Arrow like VSCode) ─────────────
nnoremap <M-h> <C-w>h
nnoremap <M-l> <C-w>l
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k

" ── Resize windows ────────────────────────────────────────
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <C-Up>    :resize -2<CR>
nnoremap <C-Down>  :resize +2<CR>

" ── Buffer navigation (like VSCode Ctrl+Tab) ──────────────
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>
nnoremap <leader>bd :bdelete<CR>        " Close buffer

" ── Saving ────────────────────────────────────────────────
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" ── Comment toggle (Ctrl+/ like VSCode) ───────────────────
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" ── Select all (Ctrl+A) ───────────────────────────────────
nnoremap <C-a> ggVG

" ── Undo / Redo (familiar keys) ───────────────────────────
nnoremap <C-z> u
nnoremap <C-y> <C-r>

" ── Move lines up/down (Alt+Up/Down like VSCode) ──────────
nnoremap <M-Up>   :m .-2<CR>==
nnoremap <M-Down> :m .+1<CR>==
vnoremap <M-Up>   :m '<-2<CR>gv=gv
vnoremap <M-Down> :m '>+1<CR>gv=gv

" ── Duplicate line (Shift+Alt+Down like VSCode) ───────────
nnoremap <S-M-Down> :t.<CR>
vnoremap <S-M-Down> :t'><CR>

" ── Clear search highlight (Escape) ───────────────────────
nnoremap <Esc> :nohlsearch<CR>

" ── Better indenting (keep selection) ─────────────────────
vnoremap < <gv
vnoremap > >gv

" ── Format entire file ────────────────────────────────────
nnoremap <leader>F :call CocAction('format')<CR>

" ── Zen mode / focus (close all other windows) ────────────
nnoremap <leader>z :only<CR>


" ════════════════════════════════════════════════════════════
"  MISC AUTO-COMMANDS
" ════════════════════════════════════════════════════════════
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
      \ | exe "normal! g'\"" | endif

" Relative numbers only in normal mode (like VSCode)
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Create undodir if it doesn't exist
if !isdirectory($HOME.'/.vim/undodir')
    call mkdir($HOME.'/.vim/undodir', 'p', 0700)
endif


" ════════════════════════════════════════════════════════════
"  COC CONFIG REFERENCE  (~/.vim/coc-settings.json)
" ════════════════════════════════════════════════════════════
" After :PlugInstall, create ~/.vim/coc-settings.json with:
"
" {
"   "suggest.noselect": false,
"   "suggest.enablePreview": true,
"   "suggest.floatEnable": true,
"   "suggest.detailField": "preview",
"   "diagnostic.displayByAle": false,
"   "diagnostic.errorSign": "",
"   "diagnostic.warningSign": "",
"   "diagnostic.infoSign": "",
"   "inlayHint.enable": true,
"   "codeLens.enable": true,
"   "hover.autoHide": true,
"   "coc.preferences.formatOnSaveFiletypes": [
"     "javascript","typescript","typescriptreact","javascriptreact",
"     "json","css","html","python","rust","go"
"   ],
"   "prettier.requireConfig": false,
"   "typescript.updateImportsOnFileMove.enabled": "always",
"   "javascript.updateImportsOnFileMove.enabled": "always"
" }

" ════════════════════════════════════════════════════════════
"  QUICK REFERENCE
" ══════════════════════════════════════════════════
" Ctrl+B          Toggle file sidebar (NERDTree)
" Ctrl+P          Open file by name (FZF)
" Ctrl+Shift+F    Search text in project (ripgrep)
" Ctrl+`          Toggle floating terminal
" Space+o         Toggle code outline (Tagbar)
" gd              Go to definition
" gr              Go to references
" K               Hover docs
" Space+rn        Rename symbol
" Space+ac        Code actions / quick fix
" Space+f         Format selection
" Space+F         Format entire file
" [g /g         Previous / next diagnostic
" Ctrl+D          Select next occurrence (multi-cursor)
" Alt+Up/Down     Move line up/down
" Space+gs        Git status
" Space+gb        Git blame
" Space+gd        Git diff
" Space+gv        Git log
" Space+\         Vertical split
" Space+-         Horizontal split
" Alt+H/J/K/L     Navigate between splits
" Shift+H/L       Previous / next buffer
" ============================================================
