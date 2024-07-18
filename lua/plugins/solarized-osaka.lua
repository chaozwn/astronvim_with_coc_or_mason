local function init_opts()
  if vim.g.neovide then
    return {}
  else
    return {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
  end
end
return {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  priority = 1000,
  opts = function(_, opts) return require("astrocore").extend_tbl(opts, init_opts()) end,
}
