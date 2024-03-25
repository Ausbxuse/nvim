return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[

		      ___              __                             
		     /   | __  _______/ /_  _  ____  __________       
		    / /| |/ / / / ___/ __ \| |/_/ / / / ___/ _ \      
		   / ___ / /_/ (__  ) /_/ />  </ /_/ (__  )  __/      
		  /_/  |_\__,_/____/_.___/_/|_|\__,_/____/\___/       
      ]]

      local thingy = io.popen('echo "now: $(date "+%I:%M %p %a, %b %d %Y")" | tr -d "\n"')
      local date = thingy:read("*a")
      thingy:close()

      local heading = {
        type = "text",
        val = "",
        opts = {
          position = "center",
          hl = "MatchParen",
        },
      }

      local heading2 = {
        type = "text",
        val = " " .. date .. "",
        opts = { position = "center", hl = "String" },
      }
      dashboard.section.heading = heading
      dashboard.section.heading2 = heading2

      dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
        dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
        dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      -- dashboard.opts.layout[1].val = 8
      --
      local section = dashboard.section

      dashboard.opts = {
        layout = {
          { type = "padding", val = 1 },
          section.header,
          { type = "padding", val = 2 },
          section.heading2,
          section.heading,
          { type = "padding", val = 1 },
          -- section.top_bar,
          section.buttons, -- section.bot_bar,
          -- { type = "padding", val = 1 },
          section.footer,
        },
        opts = { margin = 5 },
      }

      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      local fortune = require("alpha.fortune")()
      --[[ local footer = {
        type = "text",
        val = fortune,
        opts = { position = "center", hl = "Comment", hl_shortcut = "Comment" },
      } ]]

      dashboard.section.footer.val = fortune
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.heading.val = "[ ⚡loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms ]"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
