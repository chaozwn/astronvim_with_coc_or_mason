---@type LazySpec

local prefix = "<Leader>w"

return {
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            opt = {
              winwidth = 10,
              winminwidth = 10,
              equalalways = false,
            },
          },
          mappings = {
            n = {
              [prefix .. "m"] = {
                function() vim.cmd [[WindowsMaximize]] end,
                desc = "Maximize Window",
              },
              [prefix .. "|"] = {
                function() vim.cmd [[WindowsMaximizeHorizontally]] end,
                desc = "Maximize Window Horizontally",
              },
              [prefix .. "\\"] = {
                function() vim.cmd [[WindowsMaximizeVertically]] end,
                desc = "Maximize Window Vertically",
              },
              [prefix .. "e"] = {
                function() vim.cmd [[WindowsEqualize]] end,
                desc = "Equalize Window",
              },
            },
          },
        },
      },
    },
    opts = {},
    cmd = {
      "WindowsMaximize",
      "WindowsMaximizeVertically",
      "WindowsMaximizeHorizontally",
      "WindowsEqualize",
      "WindowsEnableAutowidth",
      "WindowsDisableAutowidth",
      "WindowsToggleAutowidth",
    },
  },
}
