local home = vim.fn.expand("$HOME")
return {
  {
    -- "ausbxuse/snappy.nvim",
    dir = home .. "/.local/src/public-repos/capture.nvim",
    config = function()
      require("capture").setup({
        capture_file_path = home .. "/Documents/Notes/Todolist.md",
      })
    end,
  },
}
