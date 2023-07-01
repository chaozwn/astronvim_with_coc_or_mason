return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
       { filter = { event = "msg_show", find = "AutoSave: saved at%s" }, opts = { skip = true } },
      },
    },
  },
}
