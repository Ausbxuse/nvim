return {
  "shortcuts/no-neck-pain.nvim",
  keys = { { "<leader>j", "<cmd>NoNeckPain<cr>", desc = "Open scratch pad" } },
  config = function()
    require("no-neck-pain").setup({
      autocmds = {
        -- When `true`, enables the plugin when you start Neovim.
        -- If the main window is  a side tree (e.g. NvimTree) or a
        -- dashboard, the command is delayed until it finds a valid window.
        -- The command is cleaned once it has successfuly ran once.
        --- @type boolean
        enableOnVimEnter = false,
        -- When `true`, enables the plugin when you enter a new Tab.
        -- note: it does not trigger if you come back to an existing tab,
        -- to prevent unwanted interfer with user's decisions.
        --- @type boolean
        enableOnTabEnter = false,
        -- When `true`, reloads the plugin configuration after a colorscheme change.
        --- @type boolean
        reloadOnColorSchemeChange = true,
      },
      width = 80,
      buffers = {
        colors = {
          blend = -0.3,
        },
        right = {
          enabled = false,
        },
        -- backgroundColor = "onedark",
        scratchPad = {
          enabled = true,
          fileName = "notes",
          location = "~/Documents/Notes/",
        },
        bo = {
          filetype = "markdown",
        },
      },
    })
  end,
}
