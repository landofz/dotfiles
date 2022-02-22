local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { text = '+' },
  },
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c', [[<cmd>lua require('gitsigns').next_hunk()<CR>]], {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c', [[<cmd>lua require('gitsigns').prev_hunk()<CR>]], {})
  end
})
