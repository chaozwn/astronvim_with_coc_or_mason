return {
  {
    "jose-elias-alvarez/typescript.nvim",
    init = function() table.insert(astronvim.lsp.skip_setup, "tsserver") end,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = function() return { server = require("astronvim.utils.lsp").config "tsserver" } end,
  },
  {
    "p00f/clangd_extensions.nvim",
    init = function() table.insert(astronvim.lsp.skip_setup, "clangd") end,
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = function() return { server = require("astronvim.utils.lsp").config "clangd" } end,
  },
  { "neovim/nvim-lspconfig", dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  } },
}

