-- ════════════════════════════════════════════════════════════
--  Neovim config — "VSCode, but it's Neovim"
--  Ported from ~/.vimrc (which is left untouched) and pushed
--  further toward VSCode parity than plain Vim could go.
--
--  Layout:
--    init.lua                bootstrap + lazy.nvim
--    lua/config/options.lua  :set equivalents (ported from vimrc)
--    lua/config/keymaps.lua  VSCode-muscle-memory bindings
--    lua/config/autocmds.lua augrouped autocmds (vimrc's bug fixed)
--    lua/config/lsp.lua      diagnostics, on_attach, keymaps
--    lua/plugins/*.lua       lazy.nvim specs (UI/editor/LSP/git/picker)
--
--  Prerequisites (already installed on this machine):
--    neovim 0.12+, ripgrep (rg), fd, a Nerd Font, node (copilot)
-- ════════════════════════════════════════════════════════════

-- Bootstrap lazy.nvim ────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader MUST be set before any mapping or plugin loads.
-- (This is the #1 bug in the old vimrc: it was set at line 475,
--  so ~22 <leader> maps silently resolved to "\" instead of Space.)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { missing = true },
  checker = { enabled = false },
  change_detection = { enabled = true, notify = false },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin", -- neo-tree replaces netrw
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
