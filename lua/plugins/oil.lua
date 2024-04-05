return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- copy default mappings here from defaults in next section
        -- OR use all default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- remove a default
        vim.keymap.del("n", "<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open: In Place"))
        -- override a default
        vim.keymap.set("n", "r", api.tree.reload, opts("Refresh"))
        -- add your mappings
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Help"))
        ---
      end

      require("nvim-tree").setup({
        on_attach = my_on_attach,
        renderer = {
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "❯",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      })
    end,
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },
}
