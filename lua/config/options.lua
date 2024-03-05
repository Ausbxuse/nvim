-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

local home = vim.fn.expand("$HOME")
local default_options = {
  -- fillchars = "eob: ",
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  colorcolumn = "80", -- fixes indentline for now
  completeopt = { "menuone", "noselect" },
  -- conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  -- foldmethod = "expr", -- folding, set to "expr" for treesitter based folding
  -- foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  -- foldminlines       = 5,
  -- foldlevel = 999,
  guifont = "JetBrains Mono:h11", -- the font used in graphical neovim applications
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  -- hlsearch = true, -- highlight all matches on previous search pattern
  -- ignorecase = true, -- ignore case in search patterns
  -- mouse = "a", -- allow the mouse to be used in neovim
  -- pumheight = 10, -- pop up menu height
  -- showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  -- smartcase = true, -- smart case
  -- smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  -- termguicolors = true, -- set term gui colors (most terminals support this)
  -- timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
  undodir = home .. "/.cache/nvim/undo", -- set an undo directory
  -- undofile = true, -- enable persistent undo
  -- updatetime = 300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- expandtab = true, -- convert tabs to spaces
  -- shiftwidth = 2, -- the number of spaces inserted for each indentation
  -- tabstop = 2, -- insert 2 spaces for a tab
  -- cursorline = true, -- highlight the current line
  -- number = true, -- set numbered lines
  -- relativenumber = true, -- set relative numbered lines
  -- numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = true, -- display long lines with wrap
  -- wrapmargin = 8,
  linebreak = true, -- set the title of window to the value of the titlestring
  spell = false,
  -- spelllang = "en",
  -- scrolloff = 8, -- is one of my fav
  -- sidescrolloff = 8,
  pumblend = 20,
  winblend = 00, -- keep notify transparent
  textwidth = 80,
  -- inccommand = "nosplit",
} ---  VIM ONLY COMMANDS  ---cmd "filetype plugin on"cmd('let &titleold="' .. TERMINAL .. '"')cmd "set inccommand=split"cmd "set iskeyword+=-"

---  SETTINGS  ---

opt.shortmess:append("c")
opt.iskeyword:append("-")

for k, v in pairs(default_options) do
  vim.opt[k] = v
end
