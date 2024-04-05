local Util = require("lazyvim.util")
local telescope = require("telescope")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<Esc>", "<cmd>nohl|lua require('notify').dismiss()<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>r", "<cmd>call Compile() <CR>")

vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>e #<cr>")
vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fd", telescope.extensions.zoxide.list)

vim.keymap.set("n", "<leader>fj", "<cmd>Telescope commands<cr>")

vim.keymap.set("n", "<leader>u", "<cmd>lua require('telescope').extensions.dict.synonyms()<cr>")

vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.keymap.set(
  "n",
  "<leader>z",
  "<cmd> lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor({}))<cr>"
)

vim.keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv")
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv")

vim.keymap.set("n", "<A-H>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-J>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-K>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-L>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
--[[ vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right) ]]

-- vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up, { desc = "No op" })
-- vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down, { desc = "No op" })
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
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Normal" })
vim.keymap.set("t", "<C-h>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-j>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-k>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-l>", "", { desc = "Noop" })
vim.keymap.set("t", "<C-/>", "", { desc = "Noop" })
vim.keymap.set("t", "<c-_>", "", { desc = "Noop" })

vim.keymap.set("n", "<C-h>", "", { desc = "Noop" })
vim.keymap.set("n", "<C-j>", "", { desc = "Noop" })
vim.keymap.set("n", "<C-k>", "", { desc = "Noop" })
vim.keymap.set("n", "<C-l>", "", { desc = "Noop" })
vim.keymap.set("n", "<C-f>", "", { desc = "Noop" })
vim.keymap.set("n", "<C-/>", "", { desc = "Noop" })
vim.keymap.set("n", "<c-_>", "", { desc = "Noop" })

vim.keymap.set("n", "<leader>be", "", { desc = "Noop" })
vim.keymap.set("n", "<leader>bD", "", { desc = "Noop" })
vim.keymap.set("n", "<leader>bd", "", { desc = "Noop" })
vim.keymap.set("n", "<leader>bb", "", { desc = "Noop" })
vim.keymap.set("n", "<c-_>", "", { desc = "Noop" })

vim.keymap.set("x", "p", "P", { desc = "Better paste" })

vim.keymap.set("n", "<leader>m", "<cmd>lua require('nabla').toggle_virt()<CR>", { desc = "Show Math" })

vim.g.help_window_maximized = false

function Toggle_window()
  if vim.g.help_window_maximized then
    vim.api.nvim_command("wincmd =") -- Equalizes the window sizes
    vim.g.help_window_maximized = false
  else
    vim.api.nvim_command("wincmd |") -- Maximize width
    vim.api.nvim_command("wincmd _") -- Maximize height
    vim.g.help_window_maximized = true
    -- vim.api.nvim_win_set_width(0, vim.o.columns) -- Use the full width of the Neovim window
    -- vim.api.nvim_win_set_height(0, vim.o.lines - 1) -- Use the full height, adjusting for the command line
  end
end

-- Correct the function name in the keymap setting

vim.keymap.set("n", "<leader>=", ":silent lua Toggle_window()<CR>", { desc = "Noop" })

--[[ vim.keymap.set("n", "<C-f>h", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-f>j", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-f>k", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-f>l", "<C-w>l", { desc = "Go to right window" }) ]]

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
]])
