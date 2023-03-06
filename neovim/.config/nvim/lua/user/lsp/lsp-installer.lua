local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end
mason.setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "gopls",
    "purescriptls",
    "rust_analyzer",
    "pyright",
  },
}

-- neodev needs to be set up before lspconfig
require("neodev").setup({})

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {
  capabilities = require("user.lsp.handlers").capabilities,
  on_attach = require("user.lsp.handlers").on_attach,
  settings = require("user.lsp.settings.sumneko_lua"),
}
lspconfig.tsserver.setup {
  capabilities = require("user.lsp.handlers").capabilities,
  on_attach = require("user.lsp.handlers").on_attach,
}
lspconfig.gopls.setup {
  capabilities = require("user.lsp.handlers").capabilities,
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
lspconfig.purescriptls.setup {
  capabilities = require("user.lsp.handlers").capabilities,
  on_attach = require("user.lsp.handlers").on_attach,
}
lspconfig.rust_analyzer.setup {
  capabilities = require("user.lsp.handlers").capabilities,
  on_attach = require("user.lsp.handlers").on_attach,
}
lspconfig.pyright.setup {
  capabilities = require("user.lsp.handlers").capabilities,
  on_attach = require("user.lsp.handlers").on_attach,
}
