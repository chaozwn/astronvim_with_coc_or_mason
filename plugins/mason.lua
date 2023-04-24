-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "clangd",
        "cssls",
        "html",
        "marksman",
        "jsonls",
        "pyright",
        "tsserver",
        "yamlls",
        "emmet-ls",
      },
    },
  },
  -- :NullLSInstall stylua
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- "prettier",
        "stylua",
        "eslint_d",
        "prettierd",
      },
    },
  },
  -- :DapInstall python
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python" },
    },
  },
}
