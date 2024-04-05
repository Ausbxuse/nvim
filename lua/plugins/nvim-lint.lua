return {
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = { "mason.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
      }
      -- opts.sources = nil
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
