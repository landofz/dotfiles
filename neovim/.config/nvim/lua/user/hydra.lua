local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

Hydra({
  name = 'Telescope',
  config = {
    color = 'teal',
    invoke_on_body = true,
    hint = {
      position = 'middle',
      border = 'rounded',
    },
  },
  mode = 'n',
  body = '<Leader>f',
  heads = {
    { 'f', cmd 'Telescope find_files' },
    { 'g', cmd 'Telescope live_grep' },
    { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
    { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
    { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
    { 'k', cmd 'Telescope keymaps' },
    { 'O', cmd 'Telescope vim_options' },
    { 'r', cmd 'Telescope resume' },
    { 'p', cmd 'Telescope projects', { desc = 'projects' } },
    { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
    { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
    { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
    { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
    { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
    { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
    { '<Esc>', nil, { exit = true, nowait = true } },
  }
})
