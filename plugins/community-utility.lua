return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = {
       routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
        { filter = { event = "msg_show", find = "%d+L,%s%d+B" },          opts = { skip = true } }, -- skip save notifications
        { filter = { event = "msg_show", find = "^%d+ more lines$" },     opts = { skip = true } }, -- skip paste notifications
        { filter = { event = "msg_show", find = "^%d+ fewer lines$" },    opts = { skip = true } }, -- skip delete notifications
        { filter = { event = "msg_show", find = "^%d+ lines yanked$" },   opts = { skip = true } }, -- skip yank notifications
        { filter = { event = "msg_show", find = "AutoSave: saved at%s" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "The only match" },       opts = { skip = true } },
      },
    }
  },
}
