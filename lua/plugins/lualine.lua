return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function getWords()
      if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
        if vim.fn.wordcount().visual_words == 1 then
          return tostring(vim.fn.wordcount().visual_words) .. " word"
        elseif not (vim.fn.wordcount().visual_words == nil) then
          return tostring(vim.fn.wordcount().visual_words) .. " words"
        else
          return tostring(vim.fn.wordcount().words) .. " words"
        end
      else
        return ""
      end
    end

    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
          return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
      end
    end

    local custom_theme = require("lualine.themes.auto")
    -- Change the background of lualine_c section for normal mode
    custom_theme.normal.a.fg = "#5fdaff" -- rgb colors are supported
    custom_theme.normal.a.bg = "#2c2e3b" -- rgb colors are supported
    custom_theme.normal.b.fg = "#5fdaff" -- rgb colors are supported
    custom_theme.normal.c.bg = "#171920" -- rgb colors are supported
    -- custom_theme.command.c.bg = "#171920" -- rgb colors are supported
    custom_theme.replace.a.bg = "#ff4a00" -- rgb colors are supported
    custom_theme.replace.b.fg = "#ff4a00" -- rgb colors are supported
    -- custom_theme.replace.c.bg = "#171920" -- rgb colors are supported
    custom_theme.visual.a.fg = "#bd93f9" -- rgb colors are supported
    custom_theme.visual.a.bg = "#2c2e3b" -- rgb colors are supported
    custom_theme.visual.b.fg = "#bd93f9" -- rgb colors are supported
    -- custom_theme.visual.c.bg = "#171920" -- rgb colors are supported
    custom_theme.insert.a.fg = "#abe15b" -- rgb colors are supported
    custom_theme.insert.a.bg = "#2c2e3b" -- rgb colors are supported
    custom_theme.insert.b.fg = "#abe15b" -- rgb colors are supported
    -- custom_theme.insert.c.bg = "#171920" -- rgb colors are supported

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        --[[ component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''}, ]]
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { { "mode", fmt = trunc(200, 4, nil, true) } },
        lualine_b = {
          "branch",
          "diff",
          { "diagnostics", sources = { "nvim_diagnostic", "coc" } },
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            path = 2, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = "落", -- Text to show when the file is modified.
              readonly = "", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for new created file before first writting
            },
          },

          {
            getWords,
            color = { fg = "#333333", bg = "#eeeeee" },
            separator = { left = "", right = "" },
          },
          { "filesize" },
        },
        lualine_x = { "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "os.date('%H:%M')" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })

    -- new config

    function searchResult(quick)
      if vim.v.hlsearch == 0 then
        return ""
      end
      local last_search = vim.fn.getreg("/")
      if not last_search or last_search == "" then
        return ""
      end
      local searchcount = vim.fn.searchcount({ maxcount = 0 })
      return vim.pesc(last_search) .. " (" .. searchcount.current .. "/" .. searchcount.total .. ")"
    end

    local function place()
      local colPre = "C:"
      local col = "%c"
      local linePre = " L:"
      local line = "%l/%L"
      return string.format("%s%s%s%s", colPre, col, linePre, line)
    end

    --- @param trunc_width number trunctates component when screen width is less then trunc_width
    --- @param trunc_len number truncates component to trunc_len number of chars
    --- @param hide_width number hides component when window width is smaller then hide_width
    --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
    --- return function that can format the component accordingly

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local function window()
      return vim.api.nvim_win_get_number(0)
    end
  end,
}
