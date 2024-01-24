return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      background_colour = "#000000",
    })
  end,
}
