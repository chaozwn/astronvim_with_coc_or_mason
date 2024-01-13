return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    if vim.g.transparent_background == false then return opts end

    local transparent_bg = vim.g.transparent_background and "#000000"

    return require("astrocore").extend_tbl(opts, {
      background_colour = transparent_bg,
    })
  end,
}
