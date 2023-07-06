if vim.g.inlay_hints_enabled then
  return {}
else
  return {
    { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  }
end
