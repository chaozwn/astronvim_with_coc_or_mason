return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      options = {
        opt = {
          conceallevel = 2,
          list = false,
          listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
          showbreak = "↪ ",
          splitkeep = "screen",
          swapfile = false,
          wrap = true,
          scrolloff = 5,
        },
        g = {
          -- resession_enabled = true,
        },
      },
    })
  end,
}
