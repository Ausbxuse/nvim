-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.cmd([[
    "autocmd Filetype tex,markdown set wrap linebreak wrapmargin=8
    "autocmd Filetype tex,markdown setlocal foldmethod=expr | setlocal foldexpr=vimtex#fold#level(v:lnum) | setlocal foldtext=vimtex#fold#text()
    " "au BufRead *.vim setlocal foldmethod=marker
    " "autocmd Filetype lua setlocal foldmethod=marker
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber

    " Remove trailing whitespaces automatically before save
    " augroup strip_ws
    "   autocmd BufWritePre * call utils#stripTrailingWhitespaces()
    " augroup END

    " save cursor's last position
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'  |   exe "normal! g`\""  | endif

    " for eslint
    "autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>

    let g:vimtex_view_method='zathura'
    let g:tex_flavor='latex'
    set conceallevel=2
    let g:vimtex_quickfix_enabled=0
    let g:vimtex_compiler_progname = 'nvr'
    let g:neovide_transparency=0.8

    let g:vimtex_syntax_conceal = {
          \ 'accents': 1,
          \ 'ligatures': 1,
          \ 'cites': 1,
          \ 'fancy': 1,
          \ 'spacing': 1,
          \ 'greek': 1,
          \ 'math_bounds': 1,
          \ 'math_delimiters': 1,
          \ 'math_fracs': 1,
          \ 'math_super_sub': 1,
          \ 'math_symbols': 1,
          \ 'sections': 1,
          \ 'styles': 1,
          \}

    
    let g:vimtex_syntax_conceal_cites = {
          \ 'type': 'brackets',
          \ 'icon': '📖',
          \ 'verbose': v:true,
          \}
    


  " autocmd FileType help setlocal winheight=100 winwidth=100
]])

-- Disable status bar in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber | set laststatus=0",
})

-- Re-enable status bar when leaving terminal mode
vim.api.nvim_create_autocmd({ "BufLeave", "TermClose" }, {
  pattern = "term://*",
  command = "set laststatus=2",
})
