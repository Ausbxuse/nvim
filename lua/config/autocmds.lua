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
    
let g:vim_markdown_math=1
let g:vim_markdown_conceal=2
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_new_list_item_indent = 1

syn region mkdMath matchgroup=mkdDelimiter start="\\\@<!\\(" end="\\)"
syn region mkdMath matchgroup=mkdDelimiter start="\\\@<!\\\[" end="\\\]"
  " autocmd FileType help setlocal winheight=100 winwidth=100
]])

--[[ -- Disable status bar in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber | set laststatus=0",
})

-- Re-enable status bar when leaving terminal mode
vim.api.nvim_create_autocmd({ "BufLeave", "TermClose" }, {
  pattern = "term://*",
  command = "set laststatus=2",
}) ]]

local on_attach = function(client, bufnr)
  local function conditional_document_changes()
    if vim.fn.mode() == "i" then -- If currently in insert mode, do nothing
      return true
    else
      return false -- Else, allow normal operation
    end
  end

  if not client._original_notify then -- Only override if not already done
    client._original_notify = client.notify
    client.notify = function(method, params)
      if method == "textDocument/didChange" and conditional_document_changes() then
        return -- Do nothing if in insert mode
      else
        -- Use the saved original notify method to avoid recursion
        client._original_notify(method, params)
      end
    end
  end
end

require("lspconfig").ltex.setup({
  on_attach = on_attach,
})

--[[ local on_attach = function(client, bufnr)
  -- Override the notify method to suppress textDocument/didChange notifications
  if not client._original_notify then
    client._original_notify = client.notify
    client.notify = function(method, params)
      if method == "textDocument/didChange" then
        -- Suppress all didChange notifications; we'll manually trigger them later
        return
      else
        client._original_notify(method, params)
      end
    end
  end

  -- Set up an autocommand to trigger a document check when leaving insert mode
  vim.api.nvim_create_autocmd("InsertLeave", {
    buffer = bufnr,
    callback = function()
      -- Manually trigger a textDocument/didChange notification for the current buffer
      -- You might need to construct the params according to the server's requirements
      local params = vim.lsp.util.make_text_document_params()
      -- Adding the necessary content changes or other parameters according to LSP spec
      -- This example assumes the server can infer the changes or that full content is sent
      params.contentChanges = { { text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") } }
      client._original_notify("textDocument/didChange", params)
    end
  })
end

require("lspconfig").ltex.setup({
  on_attach = on_attach,
}) ]]
