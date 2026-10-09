-- Editing superpowers: treesitter, completion helpers, comments,
-- multi-cursor, surround, autopairs, terminal, sessions.
return {
  -- ── Syntax / folds / indent (nvim-treesitter "main" branch) ─
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- README: does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      ts.install({
        "bash", "c", "cpp", "css", "diff", "gitcommit", "gitignore",
        "go", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "python", "query", "regex", "rust", "toml",
        "tsx", "typescript", "vim", "vimdoc", "yaml",
      })

      -- Highlight + indent per filetype (README's recommended wiring)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_per_filetype", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
          pcall(function()
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        end,
      })
    end,
  },

  -- ── Syntax-aware text objects (af/if function, ]f jump, ...) ─
  -- nvim-treesitter's "main" branch no longer bundles these, and the
  -- standalone plugin's "main" branch is the matching rewrite. Loaded at
  -- VeryLazy rather than lazily: treesitter itself is lazy=false, and these
  -- are used from normal/visual/operator-pending where a keys-trigger stub
  -- is awkward. `no_plugin_maps` mutes the built-in ftplugin maps (e.g. python's
  -- af/if) that would otherwise collide with these.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
            ["@block.outer"] = "V",
            ["@loop.outer"] = "V",
            ["@statement.outer"] = "V",
          },
        },
        move = { set_jumps = true },
      })

      local sel = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local map = vim.keymap.set
      local modes = { "x", "o" }

      -- Select a text object (used with an operator: daf, yic, ...) or in
      -- visual mode to select it directly.
      local function textobject(query)
        return function() sel.select_textobject(query, "textobjects") end
      end
      map(modes, "af", textobject("@function.outer"), { desc = "Around function" })
      map(modes, "if", textobject("@function.inner"), { desc = "Inside function" })
      map(modes, "ac", textobject("@class.outer"), { desc = "Around class" })
      map(modes, "ic", textobject("@class.inner"), { desc = "Inside class" })
      map(modes, "al", textobject("@loop.outer"), { desc = "Around loop" })
      map(modes, "il", textobject("@loop.inner"), { desc = "Inside loop" })
      map(modes, "ab", textobject("@block.outer"), { desc = "Around block" })
      map(modes, "ib", textobject("@block.inner"), { desc = "Inside block" })
      map(modes, "aa", textobject("@parameter.outer"), { desc = "Around argument" })
      map(modes, "ia", textobject("@parameter.inner"), { desc = "Inside argument" })

      -- Jump between text objects (adds to the jumplist via set_jumps).
      -- ]f/[f, ]a/[a and ]l/[l are not Vim built-ins, so nothing is clobbered
      -- (unlike ]c which is diff/conflict and ]s which is spell).
      local function jump(query, forward)
        return function()
          move[forward and "goto_next_start" or "goto_previous_start"](query, "textobjects")
        end
      end
      map(modes, "]f", jump("@function.outer", true), { desc = "Next function" })
      map(modes, "[f", jump("@function.outer", false), { desc = "Prev function" })
      map(modes, "]a", jump("@parameter.outer", true), { desc = "Next argument" })
      map(modes, "[a", jump("@parameter.outer", false), { desc = "Prev argument" })
      map(modes, "]l", jump("@loop.outer", true), { desc = "Next loop" })
      map(modes, "[l", jump("@loop.outer", false), { desc = "Prev loop" })
    end,
  },

  -- ── Auto-pairs ─────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true, map_cr = false },
  },

  -- ── Surround (ysaw, ds, cs — same motions as vimrc) ────────
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- ── Comments (Ctrl+/ like VSCode) ──────────────────────────
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Toggle comment line" },
      { "gc", mode = { "n", "x" }, desc = "Comment operator" },
      {
        "<C-/>",
        mode = "n",
        desc = "Toggle comment (VSCode Ctrl+/)",
        function() require("Comment.api").toggle.linewise.current() end,
      },
      {
        "<C-/>",
        mode = "x",
        desc = "Toggle comment (VSCode Ctrl+/)",
        function()
          local api = require("Comment.api")
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
          api.toggle.linewise(vim.fn.visualmode())
        end,
      },
      {
        "<C-_>",
        mode = "n",
        desc = "Toggle comment (Ctrl+/ on some layouts)",
        function() require("Comment.api").toggle.linewise.current() end,
      },
      {
        "<C-_>",
        mode = "x",
        desc = "Toggle comment (Ctrl+/ on some layouts)",
        function()
          local api = require("Comment.api")
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
          api.toggle.linewise(vim.fn.visualmode())
        end,
      },
    },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("ts_context_commentstring").setup({ enable_autocmd = false })
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function()
      -- skip module require on every filetype (README recommendation)
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },

  -- ── Multi-cursor (Ctrl+D like VSCode) ──────────────────────
  -- Deliberate tradeoff: vim-visual-multi maps "Find Under" in normal mode
  -- too, so <C-d> no longer scrolls half a page once this loads. That is
  -- correct VSCode parity (Ctrl+D = add next occurrence), and <C-f>/<C-b>
  -- still do half-page scroll if you want it.
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select All"] = "<C-S-l>", -- VSCode Ctrl+Shift+L
        ["Add Cursor Down"] = "<C-S-Down>",
        ["Add Cursor Up"] = "<C-S-Up>",
      }
    end,
  },

  -- ── Jump anywhere on screen (flash replaces easymotion) ────
  -- flash's own defaults take s/S (its whole point). That costs substitute-char
  -- and substitute-line, whose native equivalents remain `cl` and `cc`.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Jump to any position",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function() require("flash").search() end,
        desc = "Search in window",
      },
    },
    opts = {},
  },

  -- ── Emmet + auto-rename tags (HTML/CSS/JSX) ────────────────
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte", "xml" },
  },
  {
    "AndrewRadev/tagalong.vim",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte", "php" },
  },

  -- ── Integrated terminal (VSCode Ctrl+`) ────────────────────
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<C-`>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal (VSCode Ctrl+`)" },
      { "<C-`>", "<cmd>ToggleTerm<CR>", mode = "t", desc = "Toggle terminal" },
      {
        "<leader>tt",
        function() require("toggleterm.terminal").Terminal:new():toggle() end,
        desc = "New terminal",
      },
      {
        "<leader>tt",
        function() require("toggleterm.terminal").Terminal:new():toggle() end,
        mode = "t",
        desc = "New terminal",
      },
    },
    opts = {
      direction = "float",
      close_on_exit = true,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        width = function() return math.floor(vim.o.columns * 0.85) end,
        height = function() return math.floor(vim.o.lines * 0.35) end,
      },
    },
  },

  -- ── Markdown preview (VSCode Ctrl+Shift+V) ─────────────────
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview" },
      { "<C-S-v>", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview (VSCode Ctrl+Shift+V)" },
    },
    config = function() vim.g.mkdp_auto_start = 0 end,
  },

  -- ── Sessions (VSCode window restore) ───────────────────────
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    keys = {
      { "<leader>qr", function() require("persistence").load() end, desc = "Restore last session" },
      {
        "<leader>qd",
        function() require("persistence").stop() end,
        desc = "Don't save session on exit",
      },
    },
    opts = {},
  },
}
