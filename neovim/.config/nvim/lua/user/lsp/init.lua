local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require("fidget").setup({})

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>dii', '<cmd>LspInstallInfo<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dig', '<cmd>LspInfo<CR>', opts)
