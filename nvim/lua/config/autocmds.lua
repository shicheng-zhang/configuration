-- Every autocmd lives in a named augroup with autocmd! so re-sourcing
-- never duplicates handlers (the old vimrc's bug: format-on-save and
-- the whitespace strip ran twice after :source $MYVIMRC).
local augroup = function(name)
  return vim.api.nvim_create_augroup("vscode_nvim_" .. name, { clear = true })
end

-- Trailing-whitespace strip on save: DISABLED (was rewriting files
-- without asking; all auto-save rewrites are off per user request).

-- Return to last edit position when opening files ─────────────
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Relative numbers only in normal mode (VSCode-like) ──────────
local numgroup = augroup("numbertoggle")
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numgroup,
  callback = function() vim.opt.relativenumber = true end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numgroup,
  callback = function() vim.opt.relativenumber = false end,
})

-- Highlight the yanked region (VSCode-like selection flash) ───
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Keep formatoptions VSCode-like (continue // comments, don't reflow) ──
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("formatoptions"),
  callback = function(ev)
    if vim.api.nvim_get_current_buf() ~= ev.buf then
      return
    end
    vim.opt_local.formatoptions:append({ "r", "o" })
    vim.opt_local.formatoptions:remove({ "c", "t" })
  end,
})

-- Never rewrite commit messages (fugitive/gitcommit buffers) ──
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("gitcommit_guard"),
  pattern = { "gitcommit", "gitrebase" },
  callback = function(ev) vim.b[ev.buf].no_strip_whitespace = true end,
})
