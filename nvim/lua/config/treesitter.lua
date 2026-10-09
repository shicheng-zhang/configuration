-- Treesitter helpers built on Neovim core APIs only (no plugin dependency).
local ts = vim.treesitter
local M = {}

-- Last node we expanded to, per expand-selection press. Held in a Lua local
-- rather than a buffer variable because treesitter nodes are userdata and
-- cannot be stored in vim.b. Guarded by buffer id so switching files starts
-- a fresh expansion.
local last = { buf = nil, node = nil }

-- VSCode-style "Expand Selection" (Shift+Alt+Right). Grows the selection to
-- the next enclosing syntax node on each press. Works with just the core
-- vim.treesitter module, so it functions even without
-- nvim-treesitter-textobjects (and for filetypes with no textobject queries).
--
-- We only walk to the parent of the node we last selected if the cursor is
-- still inside it, so moving the cursor and pressing the key starts a fresh
-- expansion rather than silently jumping to some unrelated ancestor.
function M.expand_selection()
  local buf = vim.api.nvim_get_current_buf()
  local mode = vim.api.nvim_get_mode().mode
  local in_visual = (mode == "v" or mode == "V" or mode == "\22")

  local node
  if in_visual and last.buf == buf and last.node then
    local cur = last.node
    local csr, _, cer = ts.get_node_range(cur)
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- Only grow if the cursor is still inside the node we last selected;
    -- if it moved elsewhere, fall through and start fresh from the cursor.
    if cursor[1] >= csr + 1 and cursor[1] <= cer + 1 then
      local c_srow, c_scol, c_erow, c_ecol = ts.get_node_range(cur)
      local parent = cur:parent()
      -- Walk up past any wrapper node that covers the exact same range as the
      -- current one (some grammars insert zero-width parents, e.g. Lua's
      -- variable_list around a lone identifier), so every press grows the
      -- selection instead of appearing to do nothing.
      while parent do
        local psr, psc, per, pec = ts.get_node_range(parent)
        if psr ~= c_srow or psc ~= c_scol or per ~= c_erow or pec ~= c_ecol then
          node = parent
          break
        end
        parent = parent:parent()
      end
    end
  end

  node = node or ts.get_node({ bufnr = buf })
  if not node then
    return
  end
  last.buf, last.node = buf, node

  local sr, sc, er, ec = ts.get_node_range(node)

  -- Re-anchor the selection: leave whatever mode we are in, park the cursor
  -- at the node start, enter visual, then extend to the node end. feedkeys
  -- with the "x" flag runs each step synchronously so the ordering holds.
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
  vim.api.nvim_feedkeys("v", "nx", false)
  vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
end

return M
