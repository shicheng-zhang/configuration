# Vim as VSCode — Complete Guide

Everything in your `.vimrc`, explained and documented.

---

## Table of Contents

1. [Plugin Overview](#plugin-overview)
2. [Basic Vim Settings](#basic-vim-settings)
3. [Theme & Appearance](#theme--appearance)
4. [NERDTree — File Sidebar](#nerdtree--file-sidebar)
5. [coc.nvim — LSP, Autocomplete & Diagnostics](#cocnvim--lsp-autocomplete--diagnostics)
6. [GitHub Copilot — AI Suggestions](#github-copilot--ai-suggestions)
7. [FZF — Fuzzy Finder](#fzf--fuzzy-finder)
8. [Tagbar — Code Outline](#tagbar--code-outline)
9. [Git Integration](#git-integration)
10. [FloaTerm — Integrated Terminal](#floaterm--integrated-terminal)
11. [Indent Guides & Rainbow Brackets](#indent-guides--rainbow-brackets)
12. [Multi-Cursor](#multi-cursor)
13. [EasyMotion — Navigation](#easymotion--navigation)
14. [ALE — Linting](#ale--linting)
15. [Auto-Pairs & Surround](#auto-pairs--surround)
16. [Emmet — HTML/CSS Expansion](#emmet--htmlcss-expansion)
17. [Startify — Start Screen](#startify--start-screen)
18. [All Key Mappings (Master Reference)](#all-key-mappings-master-reference)
19. [coc-settings.json Reference](#coc-settingsjson-reference)
20. [Installing LSP Servers](#installing-lsp-servers)
21. [Troubleshooting](#troubleshooting)

---

## Plugin Overview

| Plugin | Purpose | VSCode Equivalent |
|---|---|---|
| `gruvbox` | Color theme | Dark+ / One Dark |
| `vim-airline` | Status bar + tab bar | Bottom status bar |
| `vim-devicons` | File-type icons | Built-in icons |
| `rainbow` | Colored bracket pairs | Bracket Pair Colorizer |
| `indentLine` | Indent guides | Built-in indent guides |
| `vim-startify` | Start screen with recent files | Welcome tab |
| `nerdtree` | File explorer sidebar | Explorer panel |
| `nerdtree-git-plugin` | Git status icons in sidebar | Source Control decorations |
| `coc.nvim` | LSP engine, autocomplete, diagnostics | IntelliSense |
| `copilot.vim` | AI code suggestions | GitHub Copilot |
| `fzf` + `fzf.vim` | Fuzzy file/text search | Ctrl+P / Ctrl+Shift+F |
| `vim-polyglot` | Syntax for 100+ languages | Built-in grammar |
| `vim-fugitive` | Full Git client | Source Control panel |
| `vim-gitgutter` | Git diff in the gutter | Gutter decorations |
| `gv.vim` | Git commit log browser | Git Graph extension |
| `vim-surround` | Add/change/delete surrounding chars | - |
| `vim-commentary` | Toggle comments | Comment toggle |
| `auto-pairs` | Auto-close brackets/quotes | Built-in |
| `vim-visual-multi` | Multiple cursors | Ctrl+D multi-select |
| `emmet-vim` | HTML/CSS shorthand expansion | Emmet Built-in |
| `tagalong.vim` | Auto-rename HTML tag pairs | Built-in HTML editing |
| `vim-floaterm` | Floating/docked terminal | Integrated terminal |
| `vim-easymotion` | Jump anywhere on screen | - |
| `incsearch.vim` | Better live search | - |
| `tagbar` | Code outline panel | Outline panel |
| `ale` | Async linting | Problems panel |
| `markdown-preview.nvim` | Live Markdown preview in browser | Markdown Preview |
| `vim-ctrlspace` | Buffer/tab/workspace manager | Tab groups |
| `vim-snippets` | Community snippet library | Built-in snippets |

---

## Basic Vim Settings

These settings are at the top of the vimrc and control core editor behavior.

### Display

| Setting | What it does |
|---|---|
| `set number` | Shows absolute line numbers in the gutter |
| `set relativenumber` | Shows relative numbers above/below cursor — great for jumping with `5j` |
| `set signcolumn=yes` | Always reserves a column for LSP/git signs; prevents layout jumping |
| `set cursorline` | Highlights the entire line the cursor is on |
| `set nowrap` | Long lines don't wrap — scroll horizontally instead |
| `set showmatch` | Briefly jumps cursor to matching bracket when you close one |
| `set scrolloff=8` | Always keeps 8 lines visible above and below the cursor |

### Indentation

| Setting | What it does |
|---|---|
| `set tabstop=2` | A tab character visually equals 2 spaces |
| `set softtabstop=2` | Tab/backspace moves 2 spaces in insert mode |
| `set shiftwidth=2` | `>>` and `<<` indent by 2 spaces |
| `set expandtab` | Pressing Tab inserts spaces, not a tab character |
| `set autoindent` | New lines match indentation of the previous line |
| `set smartindent` | Adds extra indent after `{`, removes it after `}` |

Change `2` to `4` in all four if your project uses 4-space indentation.

### Search

| Setting | What it does |
|---|---|
| `set incsearch` | Highlights matches as you type the search pattern |
| `set hlsearch` | Keeps matches highlighted after you confirm search |
| `set ignorecase` | Search is case-insensitive by default |
| `set smartcase` | Becomes case-sensitive if you type any uppercase letter |

### Files & Buffers

| Setting | What it does |
|---|---|
| `set autoread` | Reloads file if it was changed on disk externally |
| `set hidden` | Lets you switch buffers without saving first |
| `set noswapfile` | Disables `.swp` files |
| `set undofile` | Saves undo history to disk — persists across Vim restarts |
| `set undodir=~/.vim/undodir` | Where undo history files are stored |
| `set clipboard=unnamedplus` | Yank/paste uses the system clipboard (Ctrl+V works) |
| `set mouse=a` | Full mouse support — click to move cursor, scroll, resize splits |

### Performance

| Setting | What it does |
|---|---|
| `set updatetime=100` | Fires `CursorHold` after 100ms idle — makes git gutter and LSP hover fast |
| `set timeoutlen=500` | How long Vim waits for a key sequence (e.g. leader combos) |
| `set lazyredraw` | Doesn't redraw screen during macros — speeds up bulk operations |

---

## Theme & Appearance

### Gruvbox

The color scheme. Set via:
```vim
colorscheme gruvbox
set background=dark
```

To try the light variant:
```vim
set background=light
```

To make the background transparent (inherits your terminal background):
```vim
hi Normal guibg=NONE ctermbg=NONE
```
Uncomment that line in the vimrc.

### Airline (Status Bar)

The bottom bar showing mode, file, git branch, LSP status, and open buffers as tabs.

Key settings:
```vim
let g:airline_powerline_fonts = 1        " Enables arrow separators (needs Nerd Font)
let g:airline#extensions#tabline#enabled = 1   " Shows open buffers as a tab bar at top
let g:airline#extensions#branch#enabled = 1    " Shows current git branch
let g:airline#extensions#coc#enabled = 1       " Shows LSP error/warning counts
```

To change the theme, replace `gruvbox` with any of: `dark`, `light`, `solarized`, `molokai`, `onedark`, `bubblegum`, `luna`.

```vim
let g:airline_theme = 'onedark'
```

---

## NERDTree — File Sidebar

Open/close with `Ctrl+B`.

### Basic Usage

| Key | Action |
|---|---|
| `Ctrl+B` | Toggle the sidebar open/closed |
| `Space+e` | Reveal the current file in the tree |
| `o` | Open file / expand folder |
| `t` | Open file in a new tab |
| `s` | Open file in a vertical split |
| `i` | Open file in a horizontal split |
| `I` | Toggle hidden files (dotfiles) |
| `m` | Open the NERDTree menu (create, rename, delete, copy files) |
| `R` | Refresh the tree |
| `?` | Toggle NERDTree help |
| `q` | Close the NERDTree panel |
| `A` | Zoom NERDTree (make it full screen, then toggle back) |
| `p` | Jump to parent directory node |
| `P` | Jump to root node |
| `C` | Set the selected directory as the new root |
| `u` | Move the root up one level |
| `cd` | Change Vim's working directory to the selected folder |

### Creating / Renaming / Deleting Files

Press `m` inside NERDTree to open the file menu:
- `a` — Create a new file or directory (end name with `/` for directory)
- `m` — Move / rename
- `d` — Delete
- `c` — Copy

### Git Status Icons

Provided by `nerdtree-git-plugin`. Icons appear next to files:

| Icon | Meaning |
|---|---|
| `✹` | Modified |
| `✚` | Staged (added) |
| `✭` | Untracked |
| `➜` | Renamed |
| `✖` | Deleted |
| `═` | Unmerged (conflict) |

### Configuration Options

```vim
let g:NERDTreeShowHidden = 1       " Show dotfiles — toggle with I at runtime
let g:NERDTreeWinSize = 35         " Sidebar width in columns
let g:NERDTreeMinimalUI = 1        " Hides the help text at the top
let g:NERDTreeIgnore = [...]       " File patterns to hide (regex)
```

Add more patterns to ignore, e.g. `'__pycache__'`, `'\.egg-info$'`.

---

## coc.nvim — LSP, Autocomplete & Diagnostics

This is the most important plugin. It uses the same LSP protocol as VSCode, so it supports the same language servers.

### Autocomplete

The autocomplete popup appears automatically as you type.

| Key | Action |
|---|---|
| `Tab` | Select next suggestion |
| `Shift+Tab` | Select previous suggestion |
| `Enter` | Confirm and insert selected suggestion |
| `Ctrl+Space` | Manually trigger completion popup |
| `Escape` | Dismiss popup |

### Go-To Navigation

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show all references |
| `K` | Show hover documentation popup |
| `Ctrl+O` | Jump back (Vim's built-in — works after `gd`) |
| `Ctrl+I` | Jump forward |

### Diagnostics (Errors & Warnings)

| Key | Action |
|---|---|
| `[g` | Jump to previous diagnostic |
| `]g` | Jump to next diagnostic |
| `Space+d` | Open the diagnostics list for the whole project |

### Code Actions (Quick Fixes)

| Key | Action |
|---|---|
| `Space+ac` | Code actions at cursor (fix, refactor, etc.) |
| `Space+as` | Code actions for entire source file |
| `Space+qf` | Apply the first/best quick fix automatically |
| `Space+re` | Refactor at cursor |

### Renaming

| Key | Action |
|---|---|
| `Space+rn` | Rename symbol under cursor (renames all references) |

### Formatting

| Key | Action |
|---|---|
| `Space+f` | Format selected code (visual mode) or current line |
| `Space+F` | Format the entire file |

Format on save is enabled automatically for: JS, TS, JSX, TSX, JSON, CSS, HTML, Python, Rust, Go.

To add/remove languages from format-on-save, edit:
```vim
autocmd BufWritePre *.ts,*.tsx,*.js ...
```

### Signature Help

When you're inside a function call and type `(`, coc automatically shows the function signature with parameter hints. This triggers via:
```vim
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
```

### Symbol Search

| Key | Action |
|---|---|
| `Space+s` | Search all symbols in the workspace |

### Floating Window Scroll

When a hover/docs popup is open:

| Key | Action |
|---|---|
| `Ctrl+F` | Scroll popup down |
| `Ctrl+B` | Scroll popup up |

### Installing Extensions

Run inside Vim:
```
:CocInstall <extension-name>
:CocUninstall <extension-name>
:CocUpdate           " Update all extensions
:CocList extensions  " See installed extensions and their status
```

### Useful coc Commands

```
:CocInfo            " Show coc status, logs, Node version
:CocRestart         " Restart the coc service
:CocConfig          " Open coc-settings.json
:CocDiagnostics     " Show all errors/warnings
:CocOutline         " Show document symbols (outline)
```

---

## GitHub Copilot — AI Suggestions

After `:Copilot setup`, Copilot suggests code as you type. Suggestions appear as ghost text.

| Key | Action |
|---|---|
| `Alt+L` | Accept the current Copilot suggestion |
| `Alt+]` | Cycle to next suggestion |
| `Alt+[` | Cycle to previous suggestion |
| `Alt+\` | Manually request a suggestion |

Tab is intentionally NOT used for Copilot acceptance — Tab belongs to coc.nvim for autocomplete.

### Enabling/Disabling per Filetype

```vim
let g:copilot_filetypes = {
  \ 'markdown': v:true,
  \ 'yaml': v:true,
  \ 'sh': v:false,      " Disable for shell scripts
  \ }
```

### Commands

```
:Copilot setup       " Authenticate with GitHub
:Copilot enable      " Enable Copilot
:Copilot disable     " Disable Copilot globally
:Copilot status      " Check if Copilot is connected
:Copilot panel       " Open a panel showing multiple suggestions
```

### Free Alternative: Codeium

Replace `github/copilot.vim` in the plugin list with:
```vim
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
```
Then run `:Codeium Auth` to authenticate (free, no subscription needed).

---

## FZF — Fuzzy Finder

Fuzzy search for files, text, buffers, commands, and more.

| Key | Action |
|---|---|
| `Ctrl+P` | Find file by name in project |
| `Ctrl+Shift+F` | Search text across entire project (requires ripgrep) |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Tab` | Switch between open buffers |
| `Space+b` | Buffer list |
| `Space+gf` | Search only Git-tracked files |
| `Space+/` | Search lines in current buffer |
| `Space+l` | Search lines across all open buffers |

### Inside the FZF popup

| Key | Action |
|---|---|
| `Enter` | Open selected file |
| `Ctrl+T` | Open in new tab |
| `Ctrl+V` | Open in vertical split |
| `Ctrl+X` | Open in horizontal split |
| `Ctrl+/` | Toggle preview window |
| `Esc` | Close FZF |

### Ripgrep (required for Ctrl+Shift+F)

Install ripgrep for fast text search:
```bash
# Ubuntu/Debian
sudo apt install ripgrep

# macOS
brew install ripgrep

# Arch
sudo pacman -S ripgrep
```

### Additional FZF Commands

You can run these manually:
```
:Files          File finder
:GFiles         Git-tracked files only
:GFiles?        Git-changed files
:Buffers        Open buffers
:Lines          Lines in all buffers
:BLines         Lines in current buffer
:Tags           ctags in project
:BTags          ctags in current buffer
:Marks          Vim marks
:Commands       All Vim commands
:Maps           All key mappings
:History        Recently opened files
:History:       Command history
:History/       Search history
:Commits        Git commits (requires fugitive)
:Rg <pattern>   Ripgrep search
:Colors         Browse color schemes
:Snippets       Browse coc snippets
```

---

## Tagbar — Code Outline

Mirrors the VSCode Outline panel. Shows functions, classes, variables, and methods in the current file.

| Key | Action |
|---|---|
| `Space+o` | Toggle the Tagbar panel |
| `Enter` | Jump to symbol under cursor |
| `p` | Preview symbol (jump but keep focus in Tagbar) |
| `Space` | Toggle fold |
| `+` | Open fold |
| `-` | Close fold |
| `*` | Open all folds |
| `=` | Close all folds |
| `q` | Close Tagbar |
| `?` | Toggle help |

### Requirements

Tagbar requires `ctags`. Install it:
```bash
# Ubuntu/Debian
sudo apt install universal-ctags

# macOS
brew install universal-ctags

# Arch
sudo pacman -S ctags
```

---

## Git Integration

### GitGutter (Gutter Signs)

Shows changed lines in the sign column, just like VSCode.

| Sign | Meaning |
|---|---|
| `+` | Added line |
| `~` | Modified line |
| `-` | Deleted line |

| Key | Action |
|---|---|
| `[c` | Jump to previous hunk (changed block) |
| `]c` | Jump to next hunk |
| `Space+hp` | Preview hunk diff in floating window |
| `Space+hs` | Stage hunk |
| `Space+hu` | Undo hunk (revert just this changed block) |

### Fugitive (Full Git Client)

| Key | Action |
|---|---|
| `Space+gs` | Open Git status (like the Source Control panel) |
| `Space+gc` | Git commit |
| `Space+gp` | Git push |
| `Space+gl` | Git pull |
| `Space+gb` | Git blame (shows who wrote each line) |
| `Space+gd` | Git diff split (current file vs HEAD) |
| `Space+gv` | Open git log browser (GV) |

### Inside `:Git` status window

| Key | Action |
|---|---|
| `s` | Stage file/hunk |
| `u` | Unstage file/hunk |
| `=` | Toggle inline diff |
| `cc` | Commit staged changes |
| `ca` | Amend last commit |
| `dd` | Open diff for file |
| `q` | Close |

### GV — Git Log Browser

Open with `Space+gv`. Browse your commit history.

| Key | Action |
|---|---|
| `Enter` | Show the diff for selected commit |
| `o` | Open the commit |
| `q` | Quit |

---

## FloaTerm — Integrated Terminal

A floating or docked terminal, like VSCode's integrated terminal.

| Key | Action |
|---|---|
| `Ctrl+\`` | Toggle terminal open/closed |
| `Space+t` | Open a new terminal instance |

### Inside the terminal

| Key | Action |
|---|---|
| `Ctrl+\` then `Ctrl+N` | Exit terminal mode (go back to normal mode) |
| `Ctrl+\`` | Close terminal (from inside) |

### Configuration

```vim
let g:floaterm_width = 0.85      " 85% of screen width
let g:floaterm_height = 0.35     " 35% of screen height
let g:floaterm_position = 'bottom'  " 'top', 'bottom', 'left', 'right', 'center', 'float'
let g:floaterm_autoclose = 1     " Auto-close when process exits
```

### Multiple terminals

```vim
:FloatermNew              " New terminal
:FloatermNext             " Switch to next terminal
:FloatermPrev             " Switch to previous terminal
:FloatermKill             " Kill current terminal
```

---

## Indent Guides & Rainbow Brackets

### Indent Guides (indentLine)

Vertical lines showing indentation depth, like VSCode's built-in guides.

```vim
let g:indentLine_char = '│'      " The character used for the guide line
```

Toggle at runtime:
```
:IndentLinesToggle
```

Change the character:
```vim
let g:indentLine_char = '|'    " Simple pipe
let g:indentLine_char = '¦'    " Broken bar
let g:indentLine_char = '┆'    " Light triple dash
```

### Rainbow Brackets

Each pair of brackets/braces/parentheses gets a unique color, making nested code readable.

```vim
let g:rainbow_active = 1    " 1 = enabled, 0 = disabled
```

Toggle at runtime:
```
:RainbowToggle
```

---

## Multi-Cursor

Works like `Ctrl+D` in VSCode — select the next occurrence of a word and edit all at once.

| Key | Action |
|---|---|
| `Ctrl+D` | Select word under cursor, then keep pressing to add next occurrence |
| `Ctrl+Alt+L` | Select ALL occurrences at once |
| `n` | Skip current, go to next (inside multi-cursor mode) |
| `q` | Remove current cursor and go to next |
| `Q` | Remove current cursor |
| `Escape` | Exit multi-cursor mode |

Once you have multiple cursors selected, you can use normal editing keys — `c` to change, `d` to delete, `i` to insert, etc. — and all cursors move together.

---

## EasyMotion — Navigation

Jump to any visible position on screen with 2 keystrokes.

| Key | Action |
|---|---|
| `s<char><char>` | Jump to any occurrence of a 2-character sequence |
| `Space+j` | Jump to a line below cursor |
| `Space+k` | Jump to a line above cursor |

**How it works:** Press `s`, type the first two characters of where you want to go. EasyMotion highlights every match and labels them with letters. Press the label and you jump there instantly.

---

## ALE — Linting

Asynchronous linting — shows errors and warnings without blocking the editor.

| Sign | Meaning |
|---|---|
| `E` | Error |
| `W` | Warning |

| Key | Action |
|---|---|
| `[e` | Jump to previous ALE error |
| `]e` | Jump to next ALE error |

### Manual commands

```
:ALEToggle          " Enable/disable ALE
:ALEInfo            " Show which linters are running for this filetype
:ALEFix             " Run fixers (formatters) on current file
:ALEDetail          " Show full error message in a preview window
```

### Configuring linters

ALE auto-detects linters based on what's installed. To pin specific ones:
```vim
let g:ale_linters = {
  \ 'python': ['flake8', 'mypy'],
  \ 'javascript': ['eslint'],
  \ 'go': ['golint', 'go vet'],
  \ }
```

To run fixers on save:
```vim
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ 'python': ['black', 'isort'],
  \ 'javascript': ['prettier', 'eslint'],
  \ }
```

---

## Auto-Pairs & Surround

### Auto-Pairs

Automatically closes `(`, `[`, `{`, `"`, `'`, `` ` `` as you type.

| Behaviour | Example |
|---|---|
| Type `(` | Inserts `()` and puts cursor inside |
| Type `{` then Enter | Inserts braces with indented new line |
| Press Backspace inside `()` | Deletes both brackets |
| Type `)` when cursor is before `)` | Moves past it instead of inserting |

### Surround

Add, change, or delete surrounding brackets, quotes, or tags.

| Key | Action | Example |
|---|---|---|
| `ys<motion><char>` | Add surrounding | `ysiw"` surrounds word with `"` |
| `cs<old><new>` | Change surrounding | `cs"'` changes `"word"` to `'word'` |
| `ds<char>` | Delete surrounding | `ds"` removes surrounding quotes |
| `yss<char>` | Surround entire line | `yss(` wraps line in `()` |
| `S<char>` (visual) | Surround selection | Select text, press `S"` |

**Examples:**
- Cursor on `hello` → `ysiw"` → `"hello"`
- Cursor inside `"hello"` → `cs"'` → `'hello'`
- Cursor inside `"hello"` → `ds"` → `hello`
- Cursor inside `<p>text</p>` → `dst` → `text`

### Commentary — Toggle Comments

| Key | Action |
|---|---|
| `Ctrl+/` | Toggle comment on current line |
| `Ctrl+/` (visual) | Toggle comment on selected lines |
| `gcc` | Toggle comment on current line (alternative) |
| `gc<motion>` | Comment over motion (e.g. `gc5j` comments 5 lines down) |

---

## Emmet — HTML/CSS Expansion

Type a shorthand expression and expand it with `Ctrl+Y,` (Ctrl+Y followed by comma).

**Examples:**

| Type | Press Ctrl+Y, | Result |
|---|---|---|
| `div` | → | `<div></div>` |
| `div.container` | → | `<div class="container"></div>` |
| `ul>li*3` | → | `<ul>` with 3 `<li>` items |
| `a[href=#]` | → | `<a href="#"></a>` |
| `h1{Hello World}` | → | `<h1>Hello World</h1>` |
| `.row>.col*2` | → | Nested divs with classes |
| `table>tr*3>td*4` | → | Table with 3 rows, 4 columns |

Emmet works in `html`, `css`, `jsx`, `tsx`, `vue`, `svelte` files by default.

---

## Startify — Start Screen

Shown when you open Vim with no file argument.

| Key | Action |
|---|---|
| Enter | Open highlighted file |
| `s` | Open in horizontal split |
| `v` | Open in vertical split |
| `t` | Open in new tab |
| `b` | Open bookmarks |
| `q` | Quit Vim |

### Sessions

```
:SSave <name>       " Save current session
:SLoad <name>       " Load a session
:SDelete <name>     " Delete a session
:SClose             " Close current session
```

### Adding Bookmarks

In your vimrc:
```vim
let g:startify_bookmarks = [
  \ { 'v': '~/.vimrc' },
  \ { 'z': '~/.zshrc' },
  \ { 'p': '~/projects' },
  \ ]
```

---

## All Key Mappings (Master Reference)

`Space` is the leader key.

### File & Sidebar

| Key | Action |
|---|---|
| `Ctrl+B` | Toggle NERDTree sidebar |
| `Space+e` | Reveal current file in NERDTree |
| `Space+o` | Toggle Tagbar outline |
| `Ctrl+P` | FZF file finder |
| `Ctrl+Shift+F` | FZF text search (ripgrep) |
| `Ctrl+Shift+P` | FZF command palette |
| `Ctrl+Tab` | FZF buffer switcher |
| `Space+b` | Buffer list |
| `Space+gf` | Search Git files |

### LSP / Code Intelligence

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show references |
| `K` | Hover documentation |
| `[g` | Previous diagnostic |
| `]g` | Next diagnostic |
| `Space+d` | Diagnostics list |
| `Space+rn` | Rename symbol |
| `Space+ac` | Code action at cursor |
| `Space+qf` | Quick fix |
| `Space+f` | Format selection |
| `Space+F` | Format file |
| `Space+s` | Search workspace symbols |

### Splits & Windows

| Key | Action |
|---|---|
| `Space+\` | Vertical split |
| `Space+-` | Horizontal split |
| `Space+z` | Close all other windows (zen mode) |
| `Alt+H` | Focus left window |
| `Alt+L` | Focus right window |
| `Alt+J` | Focus window below |
| `Alt+K` | Focus window above |
| `Ctrl+Left` | Shrink vertical split |
| `Ctrl+Right` | Grow vertical split |
| `Ctrl+Up` | Shrink horizontal split |
| `Ctrl+Down` | Grow horizontal split |

### Buffers & Tabs

| Key | Action |
|---|---|
| `Shift+H` | Previous buffer |
| `Shift+L` | Next buffer |
| `Space+bd` | Delete (close) current buffer |
| `Ctrl+Tab` | FZF buffer list |

### Editing

| Key | Action |
|---|---|
| `Ctrl+S` | Save file |
| `Ctrl+A` | Select all |
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Ctrl+/` | Toggle comment |
| `Ctrl+D` | Multi-cursor: add next occurrence |
| `Ctrl+Alt+L` | Multi-cursor: select all occurrences |
| `Alt+Up` | Move line up |
| `Alt+Down` | Move line down |
| `Shift+Alt+Down` | Duplicate line |
| `>` (visual) | Indent selection (keeps selection) |
| `<` (visual) | Unindent selection (keeps selection) |

### Git

| Key | Action |
|---|---|
| `Space+gs` | Git status |
| `Space+gc` | Git commit |
| `Space+gp` | Git push |
| `Space+gl` | Git pull |
| `Space+gb` | Git blame |
| `Space+gd` | Git diff |
| `Space+gv` | Git log browser |
| `[c` | Previous hunk |
| `]c` | Next hunk |
| `Space+hp` | Preview hunk |
| `Space+hs` | Stage hunk |
| `Space+hu` | Undo hunk |

### Terminal

| Key | Action |
|---|---|
| `Ctrl+\`` | Toggle floating terminal |
| `Space+t` | New terminal |
| `Ctrl+\ Ctrl+N` | Exit terminal insert mode |

### Navigation

| Key | Action |
|---|---|
| `s<c1><c2>` | EasyMotion jump to 2-char sequence |
| `Space+j` | EasyMotion jump down |
| `Space+k` | EasyMotion jump up |
| `Escape` | Clear search highlights |

### AI (Copilot)

| Key | Action |
|---|---|
| `Alt+L` | Accept Copilot suggestion |
| `Alt+]` | Next Copilot suggestion |
| `Alt+[` | Previous Copilot suggestion |
| `Alt+\` | Request suggestion |

---

## coc-settings.json Reference

Create this file at `~/.vim/coc-settings.json` (or open with `:CocConfig`):

```json
{
  "suggest.noselect": false,
  "suggest.enablePreview": true,
  "suggest.floatEnable": true,
  "suggest.detailField": "preview",
  "suggest.snippetIndicator": "►",

  "diagnostic.displayByAle": false,
  "diagnostic.errorSign": "E",
  "diagnostic.warningSign": "W",
  "diagnostic.infoSign": "I",
  "diagnostic.hintSign": "H",
  "diagnostic.virtualText": true,
  "diagnostic.virtualTextCurrentLineOnly": false,

  "inlayHint.enable": true,
  "codeLens.enable": true,
  "hover.autoHide": true,

  "coc.preferences.formatOnSaveFiletypes": [
    "javascript", "typescript", "typescriptreact", "javascriptreact",
    "json", "jsonc", "css", "scss", "html", "python", "rust", "go"
  ],

  "prettier.requireConfig": false,
  "prettier.singleQuote": true,
  "prettier.semi": true,
  "prettier.tabWidth": 2,

  "typescript.updateImportsOnFileMove.enabled": "always",
  "javascript.updateImportsOnFileMove.enabled": "always",

  "python.linting.enabled": true,
  "python.formatting.provider": "black",

  "rust-analyzer.checkOnSave.command": "clippy"
}
```

---

## Installing LSP Servers

Run any of these inside Vim with `:CocInstall`:

### Web Development
```
coc-tsserver          TypeScript & JavaScript
coc-html              HTML
coc-css               CSS, SCSS, Less
coc-json              JSON with schema validation
coc-eslint            ESLint
coc-prettier          Prettier formatter
coc-emmet             Emmet completions in LSP
```

### Systems & Backend
```
coc-rust-analyzer     Rust
coc-clangd            C & C++ (requires clangd installed)
coc-go                Go (requires gopls)
coc-pyright           Python (type-aware)
coc-java              Java (requires JDK 11+)
coc-lua               Lua
```

### Data & Config
```
coc-yaml              YAML with schema support
coc-toml              TOML
coc-docker            Dockerfile
coc-sh                Bash/Shell scripts
```

### Editor Features
```
coc-snippets          Snippet engine (works with vim-snippets)
coc-pairs             Smart bracket pairing
coc-highlight         Word highlighting
coc-spell-checker     Spell checking
coc-git               Git integration (adds blame, diff to coc)
coc-explorer          Alternative file explorer (if you prefer to NERDTree)
```

---

## Troubleshooting

### coc.nvim isn't working
```
:CocInfo            " Check for errors — most common is missing Node.js
:CocRestart         " Restart the language server
```
Make sure Node.js v16+ is installed: `node --version`

### Icons are showing as boxes or question marks
Your terminal font is not set to a Nerd Font. Download one from https://www.nerdfonts.com and set it in your terminal's font settings. JetBrainsMono Nerd Font and FiraCode Nerd Font are popular choices.

### Sign column errors (E239)
The sign text is too wide for Vim. Replace any icon characters in `ale_sign_error`, `ale_sign_warning`, and `gitgutter_sign_*` with 1–2 character ASCII strings like `E`, `W`, `+`, `~`, `-`.

### Copilot not suggesting
Run `:Copilot status`. If it says not authenticated, run `:Copilot setup` again. Also check `:Copilot enable` is on.

### FZF Ctrl+Shift+F not working
Install ripgrep: `sudo apt install ripgrep` or `brew install ripgrep`.

### NERDTree shows no icons
Same as the box icons issue — needs a Nerd Font in the terminal.

### Autocomplete not triggering
Run `:CocList extensions` and check the relevant language extension shows `✓`. If it shows `✗`, the language server may have failed — run `:CocInstall <extension>` again.

### Vim feels slow
- Set `set updatetime=300` instead of 100
- Disable `rainbow` for large files: `:RainbowToggle`
- Disable `indentLine` for large files: `:IndentLinesDisable`
- Check if ALE is running many linters: `:ALEInfo`

### Changes to vimrc not taking effect
Either restart Vim or source the vimrc manually:
```
:source ~/.vimrc
```
