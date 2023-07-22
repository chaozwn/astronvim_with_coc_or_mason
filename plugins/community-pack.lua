return {
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.prisma" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.typescript" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.tailwindcss" } or {},
  { import = "astrocommunity.pack.markdown" },
  (vim.fn.executable "python" == 1 or vim.fn.executable "python3" == 1) and { import = "astrocommunity.pack.python" }
    or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.docker" } or {},
  vim.fn.executable "go" == 1 and { import = "astrocommunity.pack.go" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.yaml" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.toml" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.json" } or {},
  vim.fn.executable "npm" == 1 and { import = "astrocommunity.pack.html-css" } or {},
  { import = "astrocommunity.pack.lua" },
}
