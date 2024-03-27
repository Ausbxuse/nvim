return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    enabled = false,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      opts.sources = vim.list_extend(opts.sources or {}, {
        --[[ nls.builtins.diagnostics.markdownlint.with({
          extra_args = { "--rules", "~MD013" }, -- Required}
        }), ]]
      })
      table.insert(
        opts.sources,
        nls.builtins.formatting.prettier.with({
          filetypes = { "markdown" },
          -- extra_args = { "--prose-wrap", "always" },
        })
      )
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { markdown = { "markdownlint" } },
    },
    config = function()
      local markdownlint = require("lint").linters.markdownlint
      markdownlint.args = {
        "--disable",
        "MD013",
        "MD007",
        "--", -- Required
      }
    end,
  },
}
