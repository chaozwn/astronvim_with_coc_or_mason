return {
  vim.fn.has "nvim-0.10" == 1 and { import = "astrocommunity.bars-and-lines.dropbar-nvim" } or {},
}
