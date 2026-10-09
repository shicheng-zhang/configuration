-- Ported from ~/.vimrc "BASIC VIM SETTINGS" + VSCode extras.
local opt = vim.opt

-- Display ────────────────────────────────────────────────────
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:2" -- reserve 2 sign cols: no layout shift when
                         -- gitsigns + LSP diagnostics appear together
opt.cursorline = true
opt.colorcolumn = ""
opt.wrap = false
opt.showmatch = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.background = "dark"
opt.numberwidth = 4
opt.showmode = false -- lualine shows the mode (VSCode status bar)
opt.pumheight = 10 -- completion menu height, VSCode-ish
opt.laststatus = 3 -- single global statusline
opt.cmdheight = 1

-- Editing ────────────────────────────────────────────────────
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true -- wrapped lines keep indent (VSCode does this)
opt.backspace = "indent,eol,start"
opt.formatoptions:append({ "r", "o" }) -- continue // comments on Enter/o
                                       -- (autocmds.lua re-asserts per filetype)

-- Search ─────────────────────────────────────────────────────
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Performance ────────────────────────────────────────────────
-- updatetime drives CursorHold/CursorHoldI (and gitsigns' debounce).
-- 100ms was too twitchy; 300ms is the common sweet spot and no longer
-- matters for signature help (that autocmd was removed — see lsp.lua).
opt.updatetime = 300
opt.timeoutlen = 500
-- Keep Esc snappy despite the <Esc> -> nohlsearch mapping in keymaps.lua.
-- Without this the default ttimeoutlen (50) makes every Escape wait 50ms
-- for a possible escape sequence. 25ms is imperceptible but halves it.
opt.ttimeoutlen = 25
opt.inccommand = "split" -- live preview of :s (VSCode-like)

-- Files / undo ───────────────────────────────────────────────
opt.autoread = true
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.confirm = true -- prompt instead of E37 on quit-with-modifications

-- Swap stays ON, unlike the old vimrc: it is your crash-recovery
-- after a SEGV. It only ever prompts when something is actually wrong.
local state = vim.fn.stdpath("state")
opt.directory = state .. "/swap//"
opt.undodir = state .. "/undo//"
vim.fn.mkdir(state .. "/swap", "p")
vim.fn.mkdir(state .. "/undo", "p")

-- Splits ─────────────────────────────────────────────────────
opt.splitright = true
opt.splitbelow = true

-- Clipboard ──────────────────────────────────────────────────
opt.clipboard = "unnamedplus" -- xclip present on this machine

-- Mouse ──────────────────────────────────────────────────────
opt.mouse = "a"

-- Command-line completion ────────────────────────────────────
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.shortmess:append("c") -- no "Press ENTER" on every completion

-- Completion menu (nvim-cmp recommendation) ──────────────────
opt.completeopt = { "menuone", "noselect" }

-- Folding: language-aware like VSCode, everything open on start ──
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Explorer replaces netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- VSCode-isms living in options
vim.g.vscode_clipboard = true -- Ctrl+C/X/V behave like VSCode (keymaps.lua)
