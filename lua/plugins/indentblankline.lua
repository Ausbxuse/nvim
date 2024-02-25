return {
  {
    "echasnovski/mini.indentscope",
    config = function()
      require("mini.indentscope").setup({

        opts = {
          -- symbol = "│",
          options = { try_as_border = true },
        },
        draw = {
          -- Delay (in ms) between event and start of drawing scope indicator
          delay = 0,

          -- Animation rule for scope's first drawing. A function which, given
          -- next and total step numbers, returns wait time (in ms). See
          -- |MiniIndentscope.gen_animation| for builtin options. To disable
          -- animation, use `require('mini.indentscope').gen_animation.none()`.
          animation = require("mini.indentscope").gen_animation.none(),

          -- Symbol priority. Increase to display on top of more symbols.
          priority = 2,
        },
        symbol = "│",
        -- symbol = "▏",
      })
    end,
  },
}
