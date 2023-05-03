-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      -- automatic_installation = true,
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
        "emmet_ls",
      },
    },
  },
  -- :NullLSInstall stylua
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      -- automatic_installation = true,
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
        "black",
        "isort",
      },
      -- {
      --   command = "stylua",
      -- },
      -- {
      --   command = "black",
      --   filetypes = { "python" },
      -- },
      -- {
      --   command = "eslint_d",
      --   filetypes = { "typescript", "typescriptreact" },
      -- },
      -- {
      --   command = "prettier",
      --   extra_args = { "--print-width", "100" },
      --   filetypes = { "javascript" },
      -- },
    },
  },
  -- :DapInstall python
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      automatic_installation = true,
      ensure_installed = { "python" },
    },
  },
}
