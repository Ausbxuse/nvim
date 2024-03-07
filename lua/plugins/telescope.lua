local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",

  keys = {
    { "<leader>fF", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Live grep" },
  },
  dependencies = {
    {
      "jvgrootveld/telescope-zoxide",
      build = "make",
      config = function()
        local home = os.getenv("HOME")
        local z_utils = require("telescope._extensions.zoxide.utils")
        local telescope = require("telescope")
        telescope.setup({
          defaults = {
            sorting_strategy = "ascending",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
              },
              vertical = {
                mirror = false,
              },
              width = 0.87,
              height = 0.80,
              preview_cutoff = 120,
            },
            file_ignore_patterns = { -- % is an escape char in lua regex
              "Media/",
              "Music/",
              ".git/",
            },
            -- Your defaults config goes in here
            theme = {
              show_line = false,
              results_title = false,
              layout_config = {
                horizontal = {
                  prompt_position = "top",
                  preview_width = 0.55,
                  results_width = 0.8,
                },
                vertical = {
                  mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
              },
            },
            --
            borderchars = {
              prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
              results = { " ", " ", " ", " ", " ", " ", " ", " " },
              preview = { " ", " ", " ", " ", " ", " ", " ", " " },
              --[[ prompt = {"─", "│", "─", "│", '┌', '┐', "┘", "└"},
      results = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
      preview = {'─', '│', '─', '│', '┌', '┐', '┘', '└'} ]]
            },
            winblend = 10,
            width = 1,
            prompt_prefix = "❯ ",
            prompt_title = "",
            -- preview_title = 'lmao'
            -- winblend = 20
            --[[ width = 1,
    layout_config = {
      vertical = {height = 0.5}
      -- other layout configuration here
    } ]]
          },
          pickers = {
            -- Your special builtin config goes in here
            buffers = {
              sort_lastused = true,
              -- theme = "ivy"
              --[[ previewer = true,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
          -- or right hand side can also be a the name of the action as string
          ["<c-d>"] = "delete_buffer"
        },
        n = {["<c-d>"] = require("telescope.actions").delete_buffer}
      } ]]
            },
            find_files = { hidden = true },
            -- commands = {theme = "ivy"}
          },
          extensions = {
            zoxide = {
              prompt_title = "[ Walking on the shoulders of TJ ]",
              mappings = {
                default = {
                  after_action = function(selection)
                    print("Update to (" .. selection.z_score .. ") " .. selection.path)
                  end,
                },
                ["<C-s>"] = {
                  before_action = function(selection)
                    print("before C-s")
                  end,
                  action = function(selection)
                    vim.cmd.edit(selection.path)
                  end,
                },
                ["<C-j>"] = {
                  keepinsert = true,
                  action = function(selection)
                    require("telescope.builtin").find_files({ cwd = selection.path })
                  end,
                },
                -- Opens the selected entry in a new split
                ["<C-q>"] = { action = z_utils.create_basic_command("split") },
              },
            },
            file_browser = {
              hidden = true,
              mappings = {
                ["i"] = {
                  -- your custom insert mode mappings
                },
                ["n"] = {
                  -- your custom normal mode mappings
                },
              },
            },
          },
          -- your extension config goes in here
        })
        require("telescope").load_extension("notify")
        telescope.load_extension("zoxide")
      end,
    },
  },
}
