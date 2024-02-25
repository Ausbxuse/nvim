return {
  "b3nj5m1n/kommentary",
  config = function()
    vim.g.kommentary_create_default_mappings = false
    vim.api.nvim_set_keymap("n", "gl", "<Plug>kommentary_line_default", {})
    vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
    vim.api.nvim_set_keymap("v", "gl", "<Plug>kommentary_visual_default<C-c>", {})
  end,
}
