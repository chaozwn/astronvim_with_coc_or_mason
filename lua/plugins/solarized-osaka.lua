return {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  priority = 1000,
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })
  end,
}
