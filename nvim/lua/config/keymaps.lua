-- VSCode-muscle-memory keymaps that do NOT depend on a plugin.
-- Plugin-owned keymaps (telescope / neo-tree / trouble / git / ...)
-- live in the `keys` fields of lua/plugins/*.lua so lazy.nvim can
-- load the plugin on first press.
--
-- NOTE: <C-S-f>, <C-S-p>, <C-Tab>, <C-S-l> only fire if your terminal
-- actually transmits distinct codes for them. If it doesn't, they harmlessly
-- do nothing and the plain <C-f>/<C-p> defaults keep working.
local map = vim.keymap.set

-- ── Splits / windows ─────────────────────────────────────────
map("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "Split right" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split down" })
map("n", "<M-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<M-l>", "<C-w>l", { desc = "Focus window right" })
map("n", "<M-j>", "<C-w>j", { desc = "Focus window down" })
map("n", "<M-k>", "<C-w>k", { desc = "Focus window up" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize narrower" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize wider" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize taller" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize shorter" })

-- ── Buffers ──────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ── Saving ───────────────────────────────────────────────────
-- Heads-up: <C-s> is flow control (XOFF) in raw terminals.
-- If it freezes the terminal, run:  stty -ixon
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>write<CR>a", { desc = "Save file" })

-- ── Undo / redo / select all ─────────────────────────────────
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- ── Number increment (C-a is taken by select-all, VSCode-style) ──
map("n", "<M-=>", "<C-a>", { desc = "Increment number" })
map("n", "<M-->", "<C-x>", { desc = "Decrement number" })

-- ── Move lines (Alt+Up/Down like VSCode) ─────────────────────
map("n", "<M-Up>", "<cmd>move .-2<CR>==", { desc = "Move line up" })
map("n", "<M-Down>", "<cmd>move .+1<CR>==", { desc = "Move line down" })
map("x", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("x", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- ── Duplicate line (Shift+Alt+Down like VSCode) ──────────────
map("n", "<S-M-Down>", "<cmd>t.<CR>", { desc = "Duplicate line down" })
map("x", "<S-M-Down>", ":t'><CR>", { desc = "Duplicate selection down" })

-- ── Better indenting (keeps the selection) ───────────────────
map("x", "<", "<gv", { desc = "Indent left" })
map("x", ">", ">gv", { desc = "Indent right" })

-- ── Clear search highlight (Escape) ──────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- ── Go to line (VSCode Ctrl+G) ───────────────────────────────
map("n", "<C-g>", function()
  vim.ui.input({ prompt = "Go to line: " }, function(input)
    local n = input and tonumber(input)
    if n then
      vim.api.nvim_win_set_cursor(0, { math.max(1, math.min(n, vim.fn.line("$"))), 0 })
    end
  end)
end, { desc = "Go to line (VSCode Ctrl+G)" })

-- ── Expand selection (VSCode Shift+Alt+Right) ────────────────
-- Grows the selection to the next enclosing treesitter node on each press.
-- Core-API implementation lives in config/treesitter.lua so it works even
-- for filetypes without textobject queries. <leader>v is a terminal-safe
-- fallback for terminals that don't send distinct Shift+Alt+Right codes.
map("n", "<S-M-Right>", function() require("config.treesitter").expand_selection() end,
  { desc = "Expand selection (VSCode Shift+Alt+Right)" })
map("x", "<S-M-Right>", function() require("config.treesitter").expand_selection() end,
  { desc = "Expand selection (VSCode Shift+Alt+Right)" })
map({ "n", "x" }, "<leader>v", function() require("config.treesitter").expand_selection() end,
  { desc = "Expand selection" })

-- ── Diagnostics navigation (F8 / Shift+F8 like VSCode) ───────
map("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Previous diagnostic" })
map("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Next diagnostic" })
map("n", "<F8>", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Next problem (VSCode F8)" })
map("n", "<S-F8>", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Previous problem (VSCode Shift+F8)" })
map("n", "<C-w>d", function() vim.diagnostic.open_float(nil, { focus = false }) end,
  { desc = "Show diagnostic under cursor" })

-- Signature help on demand (VSCode Ctrl+K Ctrl+I). Not auto-triggered —
-- an idle-timer popup was too noisy (see config/lsp.lua).
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature help (VSCode Ctrl+K Ctrl+I)" })
map("i", "<C-S-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- ── LSP (global; harmless until a server attaches) ───────────
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition (VSCode F12)" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references (VSCode Shift+F12)" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition (VSCode F12)" })
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "Find references (VSCode Shift+F12)" })
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol (VSCode F2)" })
map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Quick fix (VSCode Ctrl+.)" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ac", vim.lsp.buf.code_action, { desc = "Code actions / quick fix" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions / quick fix (alias)" })
map("x", "<leader>af", function()
  vim.lsp.buf.code_action({ range = {
    start = { vim.fn.line("v"), vim.fn.col("v") },
    ["end"] = { vim.fn.line("."), vim.fn.col(".") },
  } })
end, { desc = "Code actions for selection" })
map("n", "<leader>as", function()
  vim.lsp.buf.code_action({ context = { only = { "source" } } })
end, { desc = "Source actions" })
map("n", "<leader>re", function()
  vim.lsp.buf.code_action({ context = { only = { "refactor" } } })
end, { desc = "Refactor" })
map("n", "<leader>qf", function()
  vim.lsp.buf.code_action({
    context = { diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }) },
  })
end, { desc = "Fix problem on this line" })

-- ── VSCode-style clipboard ───────────────────────────────────
-- Ctrl+C with no selection copies the line, Ctrl+X cuts the line,
-- Ctrl+V pastes. Blockwise-visual stays available on Ctrl+Q
-- (Vim's built-in alternative for Ctrl+V).
if vim.g.vscode_clipboard then
  map("n", "<C-c>", '"+yy', { desc = "Copy line" })
  map("x", "<C-c>", '"+y', { desc = "Copy selection" })
  map("n", "<C-x>", '"+dd', { desc = "Cut line" })
  map("x", "<C-x>", '"+d', { desc = "Cut selection" })
  map("n", "<C-v>", '"+p', { desc = "Paste" })
  map("x", "<C-v>", '"+p', { desc = "Paste over selection" })
  map("i", "<C-v>", "<C-r>+", { desc = "Paste" })
end
