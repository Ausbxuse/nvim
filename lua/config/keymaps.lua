local Util = require("lazyvim.util")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>r", ":call Compile() <CR>")

vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>b<cr>", "<cmd>e #<cr>")
vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fd", ":Telescope cder hidden=true<cr>")

vim.keymap.set("n", "<leader>fj", "<cmd>Telescope commands<cr>")

vim.keymap.set("n", "<leader>u", "<cmd>lua require('telescope').extensions.dict.synonyms()<cr>")

vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.keymap.set(
  "n",
  "<leader>sp",
  "<cmd> lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor({}))<cr>"
)

vim.keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv")
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "", { desc = "No op" })
vim.keymap.set("n", "<A-k>", "", { desc = "No op" })
vim.keymap.set("i", "<A-j>", "", { desc = "No op" })
vim.keymap.set("i", "<A-k>", "", { desc = "No op" })
vim.keymap.set("v", "<A-j>", "", { desc = "No op" })
vim.keymap.set("v", "<A-k>", "", { desc = "No op" })

vim.keymap.set("x", "al", function()
  require("align").align_to_string(false, true, true)
end, NS) -- Aligns to a string, looking left and with previews

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>fT", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>\\", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal vim.keymap.setpings
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Normal" })
vim.keymap.set("t", "<C-h>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-j>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-k>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-l>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-/>", "", { desc = "Noop" })
vim.keymap.set("t", "<c-_>", "", { desc = "Noop" })

if vim.bo.filetype == "NvimTree" then
  local api = require("nvim-tree.api")
  vim.keymap.del("n", "<CR>")
  vim.keymap.set("n", "<CR>", function()
    api.tree.change_root_to_node()
  end, NS)
  vim.keymap.set("n", "l", function()
    api.node.open.edit()
  end, NS)
else
  vim.cmd("map l l")
end

vim.cmd([[
map <leader>c :silent w! \| silent !compile "%:p"<CR>
map <leader>p :silent !opout "%:p"<CR>

func! Compile()
exec 'w'
if &filetype == "cpp"
exec 'silent vs | vert res -10 | te g++ -g -Wall % && ./a.out'
elseif &filetype == 'c'
exec 'vs | vert res -10 | te gcc -g -Wall % && ./a.out'
elseif &filetype == 'python'
exec 'vs | vert res -10 | te python3 %'
elseif &filetype == 'rust'
exec 'vs | vert res -10 | te cargo run'
elseif &filetype == 'javascript'
exec 'vs | vert res -10 | te node %'
elseif &filetype == 'javascriptreact'
exec 'vs | vert res -10 | te node %'
elseif &filetype == 'lua'
exec 'vs | vert res -10 | te lua %'
elseif &filetype == 'sh'
exec 'vs | vert res -10 | te ./%'
elseif &filetype == 'bash'
exec 'vs | vert res -10 | te ./%'
elseif &filetype == 'java'
exec 'vs | vert res -10 | te javac -classpath *.jar --module-path deps -d bin src/main/*.java'
elseif &filetype == 'markdown'
exec 'silent !compile %&'
elseif &filetype == 'html'
exec 'silent !live-server &'
endif
endfunc

function! ToggleZoom(zoom)
if exists("t:restore_zoom") && (a:zoom == v:true || t:restore_zoom.win != winnr())
exec t:restore_zoom.cmd
unlet t:restore_zoom
elseif a:zoom
let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
exec "normal \<C-W>\|\<C-W>_"
endif
endfunction

augroup restorezoom
au WinEnter * silent! :call ToggleZoom(v:false)
augroup END
]])
