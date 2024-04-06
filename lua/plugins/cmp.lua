local home = vim.fn.expand("$HOME")

local function set_path(file_path)
  local file_stat = vim.loop.fs_stat(file_path)
  local path_variable = file_stat and file_path or nil
  return path_variable
end

return {
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    enabled = true,
    keys = function()
      return {}
    end,
  },
  {
    "ausbxuse/luasnip-latex-snippets.nvim",
    dir = set_path(home .. "/.local/src/public-repos/luasnip-latex-snippets.nvim"),
    event = "VeryLazy",
    config = function()
      require("luasnip-latex-snippets").setup({
        allow_on_markdown = true,
      })
      -- Modify existing snippets using higher priority and util function from luasnip-latex-snippets
      local ls = require("luasnip")
      ls.config.setup({ enable_autosnippets = true })
      local s = ls.snippet
      local i = ls.insert_node
      local fmta = require("luasnip.extras.fmt").fmta
      local utils = require("luasnip-latex-snippets.util.utils")
      local not_math = utils.with_opts(utils.not_math, false) -- when using treesitter, change false to true

      ls.add_snippets("tex", {
        s(
          { trig = "mk", snippetType = "autosnippet", priority = 100 },
          fmta("$<>$<>", { i(1), i(2) }),
          { condition = not_math }
        ),
        s(
          { trig = "choose", snippetType = "autosnippet", priority = 100 },
          fmta("\\binom{<>}{<>}<>", { i(1), i(2), i(3) }),
          { condition = not not_math }
        ),
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc", -- nvim-cmp source for math calculation.
      "hrsh7th/cmp-emoji", -- nvim-cmp source for math calculation.
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.experimental.ghost_text = true
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "spell" },
        { name = "emoji" },
        { name = "calc" },
      }, {
        -- { name = "buffer" },
      })

      opts.formatting.fields = { "abbr", "menu", "kind" }
      opts.formatting.format = function(entry, item)
        -- Define menu shorthand for different completion sources.
        local menu_icon = {
          nvim_lsp = "LSP",
          luasnip = "SNP",
          buffer = "BUF",
          path = "PTH",
        }

        local icons = require("lazyvim.config").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        -- Set the menu "icon" to the shorthand for each completion source.
        item.menu = menu_icon[entry.source.name]

        -- Set the fixed width of the completion menu to 60 characters.
        local fixed_width = 35

        -- Set 'fixed_width' to false if not provided.
        -- fixed_width = fixed_width or false

        -- Get the completion entry text shown in the completion window.
        local content = item.abbr

        -- Set the fixed completion window width.
        if fixed_width then
          vim.o.pumwidth = fixed_width
        end

        -- Get the width of the current window.
        local win_width = vim.api.nvim_win_get_width(0)

        -- Set the max content width based on either: 'fixed_width'
        -- or a percentage of the window width, in this case 20%.
        -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
        local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

        -- Truncate the completion entry text if it's longer than the
        -- max content width. We subtract 3 from the max content width
        -- to account for the "..." that will be appended to it.
        if #content > max_content_width then
          item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
        else
          item.abbr = content .. (" "):rep(max_content_width - #content)
        end
        return item
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.config.disable,
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          elseif cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            -- cmp.select_next_item()
            cmp.confirm({ select = true })
          elseif has_words_before() then
            cmp.complete()
          elseif vim.api.nvim_get_current_line():match("^%s*-%s") then
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.cmd("normal! >>")
            vim.api.nvim_win_set_cursor(0, { row, col + 2 })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif vim.api.nvim_get_current_line():match("^%s*-%s") then
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.cmd("normal! <<")
            if col > 7 then
              vim.api.nvim_win_set_cursor(0, { row, col - 2 })
            else
              vim.api.nvim_win_set_cursor(0, { row, 6 })
            end
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
