return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",

  -- TODO: get rid of lazygit's <leader> gg bind
  keys = { { "<leader>gg", "<cmd>ChatGPT<cr>", desc = "Open ChatGPT 3.5 Turbo" } },
  config = function()
    local home = vim.fn.expand("$HOME")
    require("chatgpt").setup({
      api_key_cmd = "gpg --decrypt " .. home .. "/Documents/gptkey2.gpg",
      openai_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 300,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      popup_layout = {
        default = "center",
        center = {
          width = "90%",
          height = "90%",
        },
        right = {
          width = "30%",
          width_settings_open = "50%",
        },
      },
      popup_window = {
        highlight = "Pmenu",
        border = {
          style = "single",
        },
      },
      popup_input = {
        highlight = "Pmenu",
        border = {
          style = "single",
        },
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
