local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- strip whitespace at EOL on save
local strip_whitespace = augroup("loz-strip-whitespace", {})
autocmd({ "BufWritePre" }, {
	group = strip_whitespace,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- highlight when yanking text
local yank_group = augroup("loz-highlight-yank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 250,
		})
	end,
})

local resize_group = augroup("loz-auto-resize", {})
autocmd("VimResized", {
	group = resize_group,
	pattern = "*",
	command = "tabdo wincmd =",
})

vim.cmd([[
augroup _my_filetype_indents
  autocmd!
  autocmd FileType javascript,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json,html,htmldjango setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType purescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

augroup _my_filetype_generic
  autocmd!
  autocmd FileType mail setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType qf set nobuflisted
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
augroup END
]])

local command = vim.api.nvim_create_user_command
-- command flubs
command("WQ", "wq", {})
command("Wq", "wq", {})
command("W", "w", {})
command("Q", "q", {})
command("Qa", "qa", {})
command("E", "e", {})

local new_zettel = function(opts)
	local dashed_title = string.gsub(opts.args, " ", "-")
	local now = os.time()
	local id = os.date("%Y%m%d%H%M%S", now)
	local filename = vim.fn.expand("~/storage/Notebook/") .. id .. "_" .. dashed_title .. ".adoc"
	vim.cmd({ cmd = "e", args = { filename } })
	local buf = vim.api.nvim_get_current_buf()
	local time = os.date("%Y-%m-%d %H:%M:%S", now)
	vim.api.nvim_buf_set_lines(buf, 0, 1, false, {
		"= " .. opts.args,
		":id: " .. id,
		":time: " .. time,
		":tags:",
	})
end
command("Zet", new_zettel, { nargs = "+" })
