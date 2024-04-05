local Util = require("lazyvim.util")

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("lazyvim.config").icons

    vim.o.laststatus = vim.g.lualine_laststatus

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

    local colors = {
      _nc = "#16141f",
      base = "#191724",
      surface = "#1f1d2e",
      overlay = "#26233a",
      muted = "#6e6a86",
      subtle = "#908caa",
      text = "#e0def4",
      magenta = "#fc317e",
      orange = "#f69c5e",
      yellow = "#f6c177",
      green = "#9cce6a",
      blue = "#4fc1ff",
      cyan = "#62d8f1",
      cyan2 = "#89ddff",
      purple = "#bd93f9",
      highlight_low = "#21202e",
      highlight_med = "#403d52",
      highlight_high = "#524f67",
      none = "NONE",
    }

    local custom_theme = require("lualine.themes.auto")
    -- Change the background of lualine_c section for normal mode
    custom_theme.normal.a.fg = "#5fdaff" -- rgb colors are supported
    custom_theme.normal.a.bg = "NONE" -- rgb colors are supported
    custom_theme.normal.b.fg = "#5fdaff" -- rgb colors are supported
    custom_theme.normal.b.bg = "NONE" -- rgb colors are supported
    custom_theme.normal.c.fg = "#eaeaea" -- rgb colors are supported
    custom_theme.normal.c.bg = "NONE" -- rgb colors are supported

    custom_theme.command.a.bg = "NONE" -- rgb colors are supported
    custom_theme.command.b.bg = "NONE" -- rgb colors are supported
    custom_theme.command.a.fg = colors.cyan2 -- rgb colors are supported
    custom_theme.command.b.fg = colors.cyan2 -- rgb colors are supported

    custom_theme.replace.a.bg = "#ff4a00" -- rgb colors are supported
    custom_theme.replace.a.fg = "NONE" -- rgb colors are supported
    custom_theme.replace.b.fg = "#ff4a00" -- rgb colors are supported
    custom_theme.replace.b.bg = "NONE" -- rgb colors are supported
    -- custom_theme.replace.c.bg = "#171920" -- rgb colors are supported
    custom_theme.visual.a.fg = "#bd93f9" -- rgb colors are supported
    custom_theme.visual.a.bg = "NONE" -- rgb colors are supported
    custom_theme.visual.b.fg = "#bd93f9" -- rgb colors are supported
    custom_theme.visual.b.bg = "NONE" -- rgb colors are supported
    -- custom_theme.visual.c.bg = "#171920" -- rgb colors are supported
    custom_theme.insert.a.fg = "#abe15b" -- rgb colors are supported
    custom_theme.insert.a.bg = "NONE" -- rgb colors are supported
    custom_theme.insert.b.fg = "#abe15b" -- rgb colors are supported
    custom_theme.insert.b.bg = "NONE" -- rgb colors are supported
    -- custom_theme.insert.c.bg = "#171920" -- rgb colors are supported
    --
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
    return {
      options = {
        icons_enabled = true,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        theme = custom_theme,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",

            fmt = trunc(200, 4, nil, true),
            padding = { left = 1, right = 1 },
          },

          {
            "branch",
            icon = "",
            color = { fg = colors.cyan2 }, -- Set branch color to rose
            -- separator = { right = " ", left = " " },
            padding = { left = 0, right = 0 }, -- Adjust the right padding to 1 },
          },
          -- { "windows", mode = 2 },
          -- { "windows", mode = 2 },
          --[[ {
            "buffers",
            buffers_color = {
              -- Same values as the general color option can be used here.
              active = Util.ui.fg("ModeMsg"),
              inactive = Util.ui.fg("MiniCursorword"),
            },
            mode = 0,
            padding = { left = 0, right = 0 },
          }, ]]
        },

        lualine_b = {},

        lualine_c = {
          -- Util.lualine.root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            -- getMyCwd,
            "filename",
            -- color = Util.ui.fg("ModeMsg"),
            file_status = true,
            path = 1,
            shorting_target = 30,
            symbols = {
              modified = "🤔", -- Text to show when the file is modified.
              readonly = "🔴", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "😶", -- Text to show for unnamed buffers.
              newfile = "🙂", -- Text to show for new created file before first writting
            },
            padding = { left = 0, right = 0 },
          },
          { "filesize", padding = { left = 0, right = 0 } },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_x = {
          { "searchcount" },
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = Util.ui.fg("Special"),
          },

          {
            getWords,
            color = { fg = "#333333", bg = "#eeeeee" },
            separator = { left = "", right = "" },
          },
        },

        lualine_y = {
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_z = {
          { "progress" },
          --[[ function()
            return " " .. os.date("%R")
          end, ]]
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
