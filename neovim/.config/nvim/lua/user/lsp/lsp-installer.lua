local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end
mason.setup {}
require("mason-lspconfig").setup {
  ensure_installed = { "sumneko_lua" },
}

local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup {
  on_attach = require("user.lsp.handlers").on_attach,
  -- capabilities = require("user.lsp.handlers").capabilities,
  settings = require("user.lsp.settings.sumneko_lua")
}
lspconfig.tsserver.setup {
  on_attach = require("user.lsp.handlers").on_attach,
  -- capabilities = require("user.lsp.handlers").capabilities,
}
lspconfig.gopls.setup {
  on_attach = require("user.lsp.handlers").on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
