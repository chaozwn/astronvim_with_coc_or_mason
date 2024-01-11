return {
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.prisma" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.typescript" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.tailwindcss" } or {},
}
