---@type LazySpec
return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = "<C-t>s",
      insert_line = "<C-t>S",
    },
  },
}
