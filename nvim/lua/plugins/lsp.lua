-- LSP + completion + formatting + problems panel.
-- (Server list & on_attach live in lua/config/lsp.lua)
return {
  -- ── Mason + lspconfig chain (README-recommended ordering: ──
  --    mason and nvim-lspconfig are in runtimepath BEFORE
  --    mason-lspconfig sets itself up)
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
      {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
          require("config.lsp").setup()
        end,
      },
    },
    opts = function()
      return { ensure_installed = require("config.lsp").servers }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      run_on_start = true,
      ensure_installed = { "prettier", "stylua", "shfmt", "ruff" },
    },
  },

  -- ── Snippets ───────────────────────────────────────────────
  {
    "L3MON4D3/LuaSnip",
    lazy = true, -- nvim-cmp depends on it, so it loads on InsertEnter
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      -- scope to friendly-snippets: without paths, lazy_load scans every
      -- package.json on runtimepath (theme repos log manifest warnings)
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
      })
    end,
  },

  -- ── Completion (VSCode-style popup) ────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_suggestion = function()
        local ok, copilot = pcall(require, "copilot.suggestion")
        return ok and copilot.is_visible()
      end
      local accept_suggestion = function()
        require("copilot.suggestion").accept()
      end

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- Tab: popup > snippet jump > Copilot ghost text > indent.
          -- (VSCode semantics: Tab never OPENS the menu — Ctrl+Space does.)
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_suggestion() then
              accept_suggestion()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Enter: confirm when the menu is open, newline otherwise
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = false })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp.mapping.complete(), -- VSCode Trigger Suggest
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
              cmdline = "[Cmd]",
            }
            item.menu = icons[entry.source.name] or ("[" .. entry.source.name .. "]")
            return item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 100 },
          { name = "luasnip", priority = 90 },
          { name = "path", priority = 80 },
        }, {
          { name = "buffer", priority = 50 },
        }),
        experimental = { ghost_text = false }, -- Copilot draws its own ghost text
      })

      -- Command-line completion (VSCode-like :) )
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })

      -- Let autopairs cooperate with confirm_done
      local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok then
        cmp.event:on("confirm_done", autopairs.on_confirm_done())
      end
    end,
  },

  -- ── Copilot: inline ghost text like VSCode ─────────────────
  {
    "zbirenbaum/copilot.lua",
    event = { "BufReadPost", "InsertEnter" },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = { -- Tab is owned by nvim-cmp (see above)
          accept = false,
          accept_word = false,
          accept_line = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      panel = { enabled = false },
    },
  },

  -- ── Formatting on save (VSCode "Format on Save") ───────────
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>F",
        function() require("conform").format({ lsp_format = "fallback", timeout_ms = 2000 }) end,
        mode = { "n", "x" }, -- x so it also formats a visual selection
        desc = "Format document / selection (VSCode Shift+Alt+F)",
      },
      {
        "<S-M-f>",
        function() require("conform").format({ lsp_format = "fallback", timeout_ms = 2000 }) end,
        desc = "Format document (VSCode Shift+Alt+F)",
      },
      -- NOTE: <leader>f is deliberately left unmapped so it can serve as the
      -- which-key "find" group (<leader>ff/fg/fw/fr). Format lives on
      -- <leader>F and <S-M-f> only.
    },
    opts = {
      format_on_save = false, -- never autoformat on save; manual keys still work
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        go = { "gofmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
    },
  },

  -- ── Problems panel (VSCode's Problems view) ────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>d", "<cmd>Trouble diagnostics toggle<CR>", desc = "Problems panel (VSCode)" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<CR>", desc = "Document symbols" },
    },
    opts = {},
  },
}
