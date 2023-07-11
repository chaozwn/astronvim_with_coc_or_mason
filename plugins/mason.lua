-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
return {
  {
    -- This is needed for pylint to work in a virtualenv. See https://github.com/williamboman/mason.nvim/issues/668#issuecomment-1320859097
    "williamboman/mason.nvim",
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
  },
  -- :NullLSInstall stylua
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
  },
  -- :DapInstall python
  {
    "jay-babu/mason-nvim-dap.nvim",
  },
}
