return {
  --------------------- rainbow2 -------------------------
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "User AstroFile",
    config = function()
      local rainbow = require "ts-rainbow"
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          query = "rainbow-parens",
          strategy = rainbow.strategy.global,
          hlgroups = {
            "TSRainbowRed",
            "TSRainbowYellow",
            "TSRainbowBlue",
            "TSRainbowOrange",
            "TSRainbowGreen",
            "TSRainbowViolet",
            "TSRainbowCyan",
          },
        },
      }
    end,
  },
}
