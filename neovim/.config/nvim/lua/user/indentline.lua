local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_use_treesitter = true

indent_blankline.setup {
  show_end_of_line = true,
}
