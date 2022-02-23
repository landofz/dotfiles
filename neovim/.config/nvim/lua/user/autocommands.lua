vim.cmd [[
augroup _my_auto_resize
  autocmd!
  autocmd VimResized * tabdo wincmd =
augroup end

augroup _my_yank_highlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout=250})
augroup end

augroup _my_filetype_indents
  autocmd!
  autocmd FileType javascript,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json,html,htmldjango setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

augroup _my_filetype_generic
  autocmd!
  autocmd FileType mail setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType qf set nobuflisted
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
augroup END
]]
