local function isTermux()
  local prefix = tostring(vim.fn.getenv("PREFIX"))
  local is_termux = prefix and prefix:find("/com.termux") ~= nil

  return is_termux
end

local conf = {}

if isTermux() then
  conf = {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",

    -- TODO: get rid of lazygit's <leader> gg bind
    keys = { { "<leader>gg", "<cmd>ChatGPT<cr>", desc = "Open ChatGPT 3.5 Turbo" } },
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt " .. home .. "/Documents/gptkey.gpg",
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
            width = "100%",
            height = "100%",
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
end

return conf
