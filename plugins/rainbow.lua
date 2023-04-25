return {
  --------------------- rainbow2 -------------------------
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    config = function()
      local rainbow = require "ts-rainbow"
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          query = {
            "rainbow-parens",
            html = "rainbow-tags",
            javascript = "rainbow-tags-react",
            tsx = "rainbow-tags",
            vue = "rainbow-tags",
            latex = "rainbow-blocks",
          },
          strategy = {
            -- rainbow.strategy.global,
            -- Use local for HTML
            -- html = rainbow.strategy["local"],
            -- jsx = rainbow.strategy["local"],
            -- python = rainbow.strategy["local"],
            -- tsx = rainbow.strategy["local"],
            -- vue = rainbow.strategy["local"],
            -- Pick the strategy for LaTeX dynamically based on the buffer size
            -- tsx = function()
            --   if vim.fn.line "$" > 10000 then
            --     return nil
            --   elseif vim.fn.line "$" > 1000 then
            --     return rainbow.strategy["global"]
            --   end
            --   return rainbow.strategy["local"]
            -- end,
            function()
              -- Disabled for very large files, global strategy for large files,
              -- local strategy otherwise
              if vim.fn.line "$" > 10000 then
                return nil
              elseif vim.fn.line "$" > 1000 then
                return rainbow.strategy["global"]
              end
              return rainbow.strategy["local"]
            end,
          },
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
