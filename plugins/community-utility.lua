return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      routes = {
        { filter = { event = "notify", find = "No information available" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "DB: Query%s" }, opts = { skip = true } },
      },
    },
  },
}
