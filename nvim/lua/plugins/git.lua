-- Git: gutter marks (gitsigns), git commands (fugitive),
-- side-by-side diffs (diffview).
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>gb",
        function() require("gitsigns").toggle_current_line_blame() end,
        desc = "Toggle inline blame (GitLens-style)",
      },
      { "<leader>gh", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
      { "]h", function() require("gitsigns").next_hunk() end, desc = "Next hunk" },
      { "[h", function() require("gitsigns").prev_hunk() end, desc = "Previous hunk" },
    },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },
      update_debounce = 100,
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hd", gs.diffthis, "Diff against index")
      end,
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Ggrep" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status (VSCode SCM panel)" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<CR>", desc = "Git pull" },
      -- their vimrc's <leader>gd = diff, <leader>gv = log
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff (split)" },
      { "<leader>gv", "<cmd>Git log --oneline --graph<CR>", desc = "Git log" },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewClose" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Diff VSCode-style (side by side)" },
      {
        "<leader>gH",
        "<cmd>DiffviewFileHistory %<CR>",
        desc = "File history (VSCode timeline)",
      },
    },
    opts = {},
  },
}
