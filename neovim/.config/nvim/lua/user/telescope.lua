local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-_>"] = actions.which_key,
      }
    },
    file_ignore_patterns = { "^[.]git/" },
  },
})
telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({hidden = true, follow = true})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>sm', builtin.keymaps, { desc = '[s]earch [m]appings' })
vim.keymap.set('n', '<leader>ss', builtin.git_files, { desc = '[s]earch git file[s]' })
