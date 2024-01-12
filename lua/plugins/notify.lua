return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    local transparent_bg = vim.g.transparent_background and "#000000"

    return require("astrocore").extend_tbl(opts, {
      background_colour = transparent_bg,
    })
  end,
}
