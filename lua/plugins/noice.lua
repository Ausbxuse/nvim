return {
  "folke/noice.nvim",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "45%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 20,
          height = 10,
        },
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
    presets = {
      lsp_doc_border = true,
    },
    lsp = {
      hover = {
        enabled = true,
        silent = false, -- set to true to not show a message if hover is not available
        opts = {
          size = {
            max_height = 10,
            max_width = 40,
          },
        }, -- merged with defaults from documentation
      },
      signature = {
        opts = {
          size = {
            height = 10,
            max_width = 40,
          },
        },
      },
    },
  },
}
