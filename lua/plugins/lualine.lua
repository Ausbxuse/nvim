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
    local function getMyCwd()
      local home = os.getenv("HOME") -- Get the home directory path
      local cwd = vim.fn.getcwd() -- Get the current working directory
      local cwd_with_tilde = cwd:gsub("^" .. home, "~") -- Replace the home directory with ~
      return cwd_with_tilde .. "/" -- Print the modified path
    end

    return {
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = custom_theme,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "" },

        lualine_c = {
          Util.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            -- getMyCwd,

            -- color = Util.ui.fg("ModeMsg"),
            "filename",
            file_status = true,
            path = 3,
            shorting_target = 40,
            symbols = {
              modified = "落", -- Text to show when the file is modified.
              readonly = "", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for new created file before first writting
            },
          },
        },
        lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
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

          {
            getWords,
            color = { fg = "#333333", bg = "#eeeeee" },
            separator = { left = "", right = "" },
          },
        },
        lualine_y = {
          -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
          -- { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          --[[ function()
            return " " .. os.date("%R")
          end, ]]
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
