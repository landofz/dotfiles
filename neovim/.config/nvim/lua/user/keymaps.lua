local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- better escape
keymap("i", "jj", "<Esc>", opts)
keymap("c", "jj", "<Esc>", opts)

-- general
keymap("n", "<leader>w", "<cmd>w<CR>", opts)
keymap("n", "<leader>l", "<cmd>b#<CR>", opts)
keymap("n", "<leader>%", [[<cmd>let @" = expand("%")<CR>]], opts) -- get current filename

-- movement
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)

-- don't interrupt v-mode due indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- config edit
keymap("n", "<leader>ve", "<cmd>vsplit $MYVIMRC<CR>", opts)
keymap("n", "<leader>vs", "<cmd>source $MYVIMRC<CR>", opts)

-- quickfix/location
keymap("n", "<leader>qq", "<cmd>cclose<CR>", opts)
keymap("n", "<leader>qc", [[<cmd>exe "crewind " . v:count1<CR>]], opts)
