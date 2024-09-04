local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- better escape
keymap("i", "jj", "<Esc>", opts)
keymap("c", "jj", "<Esc>", opts)

-- general
keymap("n", "<leader>w", "<cmd>w<CR>", opts) -- write buffer
keymap("n", "<leader>l", "<cmd>b#<CR>", opts) -- switch to last used buffer
keymap("n", "<leader>%", [[<cmd>let @" = expand("%:t")<CR>]], opts) -- get current filename
keymap("x", "<leader>p", [["_dP]], opts) -- paste without touching registers
keymap("n", "<leader>y", [["+y]], opts) -- yank to system clipboard
keymap("v", "<leader>y", [["+y]], opts) -- yank to system clipboard

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
keymap("n", "<C-j>", [[:cnext<CR>zz]], opts)
keymap("n", "<C-k>", [[:cprev<CR>zz]], opts)
keymap("n", "<C-q>", "<cmd>cclose | helpclose | lclose<CR>", opts)

-- center view on search result
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- manually fixing syntax highlighting going out of sync
map("n", "<Leader>fh", [[:syntax sync fromstart<CR>]])

-- invoking plugins
map("n", "<leader>n", [[:Lexplore<CR>]])
map("n", "<leader>u", [[:UndotreeToggle<CR>]])
