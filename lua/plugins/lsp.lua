local function isTermux()
  -- Attempt to get the PREFIX environment variable and convert it to a string
  local prefix = tostring(vim.fn.getenv("PREFIX"))
  local is_termux = prefix and prefix:find("/com.termux") ~= nil

  return is_termux
end

-- Usage example
local conf = {}
if isTermux() then
  conf = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {},
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {},
      },
      config = function()
        require("mason-lspconfig").setup({
          ensured_installed = {},
        })
      end,
    },
  }
end

return conf
