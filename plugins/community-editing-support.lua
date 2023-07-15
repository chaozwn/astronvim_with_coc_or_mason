return {
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = true,
          signcolumn = "yes",
          foldcolumn = "1",
          list = true, -- show whitespace characters
        },
      },
    },
  },
}
