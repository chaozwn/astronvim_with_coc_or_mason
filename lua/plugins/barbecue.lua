return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  --NOTE: https://github.com/utilyre/barbecue.nvim/pull/93
  commit = "aae71aebec4429a8e1e3e5a8e8220f8dc48ec06d",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    show_modified = true,
    exclude_filetypes = { "netrw", "toggleterm" },
  },
}
