return {
  "lukas-reineke/headlines.nvim",
  config = function()
    require("headlines").setup({
      markdown = {
        headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
        bullet_highlights = {
          "@text.title.1.marker.markdown",
          "@text.title.2.marker.markdown",
          "@text.title.3.marker.markdown",
          "@text.title.4.marker.markdown",
          "@text.title.5.marker.markdown",
          "@text.title.6.marker.markdown",
          "@text.title.7.marker.markdown",
        },
        -- bullets = { "◉", "○", "●", "○", "●", "✿", "✸" },
        bullets = {},
        fat_headlines = true,
        fat_headline_upper_string = "▄",
        fat_headline_lower_string = "▀",
      },
    })
  end,
}
