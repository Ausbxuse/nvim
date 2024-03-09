local home = vim.fn.expand("$HOME")

local function set_path(file_path)
  local file_stat = vim.loop.fs_stat(file_path)
  local path_variable = file_stat and file_path or nil
  return path_variable
end

return {
  {
    "ausbxuse/snappy.nvim",
    dir = set_path(home .. "/.local/src/public-repos/capture.nvim"),
    config = function()
      require("capture").setup({
        capture_file_path = set_path(home .. "/Documents/Notes/Todolist.md"),
      })
    end,
  },
}
