-- Shared LSP behaviour: diagnostics (VSCode-style), on_attach extras
-- (inlay hints, breadcrumbs, signature help), capabilities for nvim-cmp.
local M = {}

-- Every server we want available (matches the vimrc's coc list).
-- Mason installs these; names are validated against nvim-lspconfig's
-- lsp/ directory — adjust here if a name drifts.
M.servers = {
  "lua_ls",
  "ts_ls",
  "pyright",
  "ruff",
  "jsonls",
  "html",
  "cssls",
  "eslint",
  "bashls",
  "yamlls",
  "gopls",
  "clangd",
  "rust_analyzer",
}

M.server_settings = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        format = { enable = false }, -- stylua via conform
      },
    },
  },
  pyright = {
    -- Always give pyright a real workspace: for loose files fall back to
    -- the file's directory (VSCode "open file" behavior). Without this
    -- pyright uses its "/<default workspace root>" placeholder and logs
    -- "File or directory ... does not exist" errors.
    root_dir = function(bufnr, on_dir)
      local name = vim.api.nvim_buf_get_name(bufnr)
      local root
      if name ~= "" then
        root = vim.fs.root(name, {
          "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg",
          "requirements.txt", "Pipfile", ".git",
        }) or vim.fs.dirname(name)
      end
      on_dir(root or vim.fn.getcwd())
    end,
    settings = {
      python = { analysis = { typeCheckingMode = "standard" } },
    },
  },
  ts_ls = {
    settings = {
      typescript = { inlayHints = { parameterNames = { enabled = "none" } } },
    },
  },
}

-- VSCode-style diagnostics ────────────────────────────────────
function M.setup_diagnostics()
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = { spacing = 2, source = "if_many" },
    float = { border = "rounded", source = true, header = "", prefix = "• " },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "E",
        [vim.diagnostic.severity.WARN] = "W",
        [vim.diagnostic.severity.INFO] = "I",
        [vim.diagnostic.severity.HINT] = "H",
      },
    },
  })
end

-- Runs for every attached server ─────────────────────────────
function M.on_attach(client, bufnr)
  -- Inlay hints (VSCode's inline parameter/type hints)
  if client:supports_method("textDocument/inlayHint") then
    pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
  end

  -- Breadcrumbs (barbecue reads nvim-navic); only servers that
  -- actually implement textDocument/documentSymbol (e.g. ruff does not)
  if client:supports_method("textDocument/documentSymbol") then
    pcall(function() require("nvim-navic").attach(client, bufnr) end)
  end

  -- Signature help is intentionally NOT auto-triggered here. An earlier
  -- CursorHoldI autocmd fired it after `updatetime` of idle in insert mode,
  -- which popped a window constantly while reading/thinking mid-statement.
  -- It stays available on demand via <leader>sh (see keymaps.lua).
end

function M.capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    caps = cmp_lsp.default_capabilities(caps)
  end
  return caps
end

-- Called from plugins/lsp.lua ────────────────────────────────
function M.setup()
  M.setup_diagnostics()

  vim.lsp.config("*", {
    capabilities = M.capabilities(),
    on_attach = M.on_attach,
  })

  for _, name in ipairs(M.servers) do
    if M.server_settings[name] then
      vim.lsp.config(name, M.server_settings[name])
    end
  end

  vim.lsp.enable(M.servers)

  -- K is hover in normal mode; keep it that way everywhere
  -- (vim.lsp.buf.hover is already mapped in keymaps.lua)
end

return M
