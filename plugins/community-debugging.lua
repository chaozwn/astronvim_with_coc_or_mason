return {
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  {
    "Weissle/persistent-breakpoints.nvim",
    keys = function() return {} end,
  },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      virt_text_pos = "eol",
    },
  },
}
