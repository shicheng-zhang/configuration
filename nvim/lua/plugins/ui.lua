-- UI: colours, status bar, tabs, explorer, panels, polish.
return {
  -- ── Colours: VSCode Dark Modern by default ────────────────
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        italic_comments = true,
        disable_nvimtree_bg = true,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
  -- One command away: `:colorscheme gruvbox`
  { "morhetz/gruvbox", lazy = false, priority = 900 },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ── Status bar (VSCode's bottom bar) ───────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          { "diagnostics", sources = { "nvim_diagnostic" } },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ── Tab bar (VSCode tabs: icons, diagnostics, close) ───────
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        always_show_bufferline = false,
        separator_style = { "", "" },
        offsets = {
          { filetype = "neo-tree", text = "Explorer", separator = true },
        },
      },
    },
  },

  -- ── File explorer sidebar (Ctrl+B) ─────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "NeoTreeToggle", "NeoTreeReveal", "NeoTreeFocus", "Neotree" },
    keys = {
      { "<C-b>", "<cmd>NeoTreeToggle<CR>", desc = "Toggle Explorer (VSCode Ctrl+B)" },
      { "<leader>e", "<cmd>NeoTreeReveal<CR>", desc = "Reveal current file in Explorer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = { hide_dotfiles = false, hide_gitignored = false },
        use_libuv_file_watchers = true,
      },
      window = {
        width = 35,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      git_status = {
        symbols = {
          added = "+",
          modified = "~",
          deleted = "-",
          renamed = "→",
          untracked = "?",
        },
      },
    },
  },

  -- ── Breadcrumbs (VSCode's breadcrumb bar) ──────────────────
  {
    "utilyre/barbecue.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    opts = { theme = "auto" },
  },

  -- ── Indent guides (VSCode's indent lines) ──────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },

  -- ── Bracket pair colourisation (VSCode feature) ───────────
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- string form straight from the plugin's README.rst
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = "rainbow-delimiters.strategy.global",
          vim = "rainbow-delimiters.strategy.local",
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- ── VSCode-style cmdline / notifications / popups ──────────
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = { view = "cmdline_popup" },
      messages = { enabled = true, view = "notify", view_error = "notify", view_warn = "notify" },
      popupmenu = { enabled = true },
      lsp = {
        progress = { enabled = true },
        signature = { auto_open = { enabled = false } }, -- handled in config/lsp.lua
        hover = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true, -- centre-screen command line, VSCode-like
        long_message_to_split = true,
        inc_rename = false,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    init = function() vim.notify = require("notify") end,
    opts = {
      stages = "fade",
      timeout = 3000,
      render = "default",
      top_down = false, -- bottom-right corner, like VSCode toasts
    },
  },

  -- ── VSCode-like input/select dialogs ───────────────────────
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  -- ── Which-key: shortcut cheatsheet (VSCode's Ctrl+K Ctrl+S) ─
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
      opts = {
        spec = {
          { "<leader>g", group = "git" },
          { "<leader>a", group = "code actions" },
          { "<leader>f", group = "find" }, -- <leader>ff/fg/fw/fr; format is <leader>F
          -- <leader>s is a direct action (document symbols), not a group, so
          -- no group entry here — otherwise which-key would offer both.
          { "<leader>q", group = "session/quickfix" },
          { "<leader>r", group = "refactor/rename" },
          { "<leader>t", group = "terminal" },
        },
      },
  },

  -- ── Start screen (welcome tab) ─────────────────────────────
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗██╗    ██╗██╗   ██╗ ██████╗ ██╗ ██████╗ ",
        "  ████╗  ██║██╔════╝██║    ██║██║   ██║██╔════╝ ██║██╔═══██╗",
        "  ██╔██╗ ██║█████╗  ██║ █╗ ██║██║   ██║██║  ███╗██║██║   ██║",
        "  ██║╚██╗██║██╔══╝  ██║███╗██║██║   ██║██║   ██║██║██║   ██║",
        "  ██║ ╚████║███████╗╚███╔███╔╝╚██████╔╝╚██████╔╝██║╚██████╔╝",
        "  ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝  ╚═════╝  ╚═════╝ ╚═╝ ╚═════╝ ",
        "                                                     ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", "<cmd>enew<CR>"),
        dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("g", "  Grep text", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("s", "  Restore session", function()
          require("persistence").load()
        end),
        dashboard.button("c", "  Settings (init.lua)", "<cmd>edit $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
      }
      dashboard.section.header.opts.hl = "Title"
      alpha.setup(dashboard.opts)
    end,
  },

  -- ── Zen mode (VSCode's View > Zen Mode) ────────────────────
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen mode (VSCode)" } },
    opts = { window = { width = 0.9 } },
  },

  -- ── Code outline sidebar (VSCode's Outline panel) ──────────
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialNavToggle", "AerialOpen" },
    keys = {
      { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Code outline (VSCode Outline)" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = { min_width = 30 },
      show_guides = true,
      filter_kind = false,
    },
  },
}
