-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.cmd([[
    autocmd Filetype tex,markdown set wrap linebreak wrapmargin=8
    autocmd Filetype tex,markdown setlocal foldmethod=expr | setlocal foldexpr=vimtex#fold#level(v:lnum) | setlocal foldtext=vimtex#fold#text()
]])
