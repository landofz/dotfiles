local options = {
	-- backups
	backup = false,
	writebackup = false,
	swapfile = false,
	undofile = true, -- save undo history
	-- security
	modelines = 0,
	shell = "sh",
	-- tabs/spaces
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	expandtab = true,
	-- appearance
	guicursor = "n-c:block,i-ci-ve:ver40,r-cr-v:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
	guifont = "monospace:h15", -- the font used in graphical interfaces
	termguicolors = true,
	-- info
	number = true, -- show line numbers
	relativenumber = true, -- use relative line numbers
	ruler = true, -- show cursor position
	laststatus = 2, -- always show the status line
	signcolumn = "yes", -- always show the sign column
	showmode = false, -- mode is already shown in the status line
	showcmd = true,
	list = true,
	listchars = { tab = "▸ ", trail = "·", eol = "¬", nbsp = "␣" },
	-- ui
	pumheight = 10, -- popup menu height
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	scrolloff = 3, -- minimal number of lines to keep above and below cursor
	hidden = true,
	visualbell = true, -- use visual bell instead of beeping
	errorbells = false, -- don't ring the bell for error messages
	wildmenu = true,
	showmatch = true,
	lazyredraw = true,
	updatetime = 250, -- decrease update time
	timeoutlen = 300, -- decreate mapped sequence wait time, display which-key popup sooner
	inccommand = "split", -- preview substitutions live
	-- search
	incsearch = true, -- search dynamically while typing
	hlsearch = true, -- highlight searches
	ignorecase = true, -- ignore case during search
	smartcase = true,
	-- diff
	diffopt = "vertical,filler,context:3,indent-heuristic,algorithm:patience,internal",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("c")

vim.g.python_host_prog = "/home/zoran/virtualenv/neovim_py2/bin/python"
vim.g.python3_host_prog = "/home/zoran/virtualenv/neovim_py3/bin/python"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.go_gopls_enabled = 0

vim.g.vim_markdown_folding_disabled = 1
