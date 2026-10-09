-- Fuzzy finder: VSCode's Ctrl+P / Ctrl+Shift+F / Ctrl+Shift+P.
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- VSCode chords
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find file (VSCode Ctrl+P)" },
      {
        "<C-S-f>",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find in files (VSCode Ctrl+Shift+F)",
      },
      { "<C-S-p>", "<cmd>Telescope commands<CR>", desc = "Command palette (Ctrl+Shift+P)" },
      { "<C-Tab>", "<cmd>Telescope buffers<CR>", desc = "Switch buffer" },
      { "<C-t>", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols (Ctrl+T)" },

      -- their vimrc's leader maps
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search this buffer" },
      {
        "<leader>l",
        function() require("telescope.builtin").live_grep({ grep_open_files = true }) end,
        desc = "Search all open buffers",
      },

      -- extra finders
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },

      -- symbols (their <leader>s = coc symbols)
      { "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols (Ctrl+Shift+O)" },
      { "<leader>S", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols (Ctrl+T)" },
      { "<C-S-o>", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "» ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          file_ignore_patterns = { "%.git/", "node_modules" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
