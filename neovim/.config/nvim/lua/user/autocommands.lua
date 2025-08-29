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

local indent_group = augroup("loz-filetype-indents", {})
autocmd("FileType", {
	group = indent_group,
	pattern = {
		"javascript",
		"typescript",
		"typescriptreact",
		"json",
		"html",
		"htmldjango",
		"terraform",
		"lua",
		"scss",
		"yaml",
		"purescript",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})
local generic_group = augroup("loz-filetype-generic", {})
autocmd("FileType", {
	group = generic_group,
	pattern = { "mail", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
	end,
})
autocmd("FileType", {
	group = generic_group,
	pattern = { "qf" },
	callback = function()
		vim.opt.buflisted = false
	end,
})
autocmd("FileType", {
	group = generic_group,
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function()
		vim.keymap.set("n", "q", function()
			vim.api.nvim_win_close(0, false)
		end, { buffer = 0, silent = true })
		vim.opt.buflisted = false
	end,
})

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
