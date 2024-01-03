return {
  { "max397574/better-escape.nvim", enabled = false },
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      local transparent_bg = vim.g.transparent_background and "#000000"

      return require("astronvim.utils").extend_tbl(opts, {
        background_colour = transparent_bg,
      })
    end,
  },
}
