local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Key mappings for LSP actions
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lgD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lgd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lgt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lgn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lgp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  float = { border = "single" },
})

-- LSP handler borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, { border = "single" })

-- Language Server Configurations
lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      nix = { binary = "nix" },
      formatting = { command = { "nixfmt", "--quiet" } },
    },
  },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["lua-language-server"] = {
      format = { enable = true },
      runtime = { version = "LuaJIT" },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
    },
  },
})

--lspconfig.lua_ls.setup({
  --capabilities = capabilities,
  --on_attach = on_attach,
  --settings = {
    --Lua = {
      --format = { enable = true },
      --runtime = { version = "LuaJIT" },
      --telemetry = { enable = false },
      --workspace = { checkThirdParty = false },
      --completion = { callSnippet = "Replace" },
    --},
  --},
--})

--lspconfig.ccls.setup({
  --capabilities = capabilities,
  --on_attach = on_attach,
  --cmd = { "ccls" },
--})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assist = { importGranularity = "crate", importEnforceGranularity = true },
      inlayHints = {
        typeHints = { enable = true },
        chainingHints = { enable = true },
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always" },
        maxLength = 5,
      },
      lens = { enable = true },
      checkOnSave = { command = "clippy", allFeatures = true },
    },
  },
})
