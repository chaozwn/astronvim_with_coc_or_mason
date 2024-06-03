return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      options = {
        opt = {
          conceallevel = 2,
          concealcursor = "",
          list = false,
          listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
          showbreak = "↪ ",
          showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
          spellfile = vim.fn.expand "~/.config/nvim/spell/en.utf-8.add",
          splitkeep = "screen",
          swapfile = false,
          thesaurus = vim.fn.expand "~/.config/nvim/spell/mthesaur.txt",
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
