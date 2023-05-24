local lsp_type = require("user.config.lsp_type").lsp_type

if lsp_type == 'coc' then
  return {
    {
      "williamboman/mason.nvim",
      enabled = false
    },
    -- coc
    {
      "jose-elias-alvarez/null-ls.nvim",
      enabled = false
    },
    {
      "jay-babu/mason-null-ls.nvim",
      enabled = false,
    },
    {
      "williamboman/nvim-lsp-installer",
      enabled = false,
    },
    {
      "neovim/nvim-lspconfig",
      enabled = false,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      enabled = false,
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      enabled = false,
    },
    {
      "lvimuser/lsp-inlayhints.nvim",
      config = false,
      enabled = false
    },
    -- dap
    {
      "mfussenegger/nvim-dap",
      enabled = false
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      enabled = false,
    },
    {
      "mfussenegger/nvim-dap-python",
      enabled = false
    },
    {
      "rcarriga/nvim-dap-ui",
      enabled = false
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      enabled = false
    },
    -- refactor
    {
      "ThePrimeagen/refactoring.nvim",
      enabled = false
    },
    -- luaship
    {
      "L3MON4D3/LuaSnip",
      enabled = false
    },
    {
      "rafamadriz/friendly-snippets",
      enabled = false
    },
    -- cmp
    {
      "hrsh7th/nvim-cmp",
      enabled = false
    },
    {
      "hrsh7th/cmp-buffer",
      enabled = false
    },
    {
      "saadparwaiz1/cmp_luasnip",
      enabled = false
    },
    {
      "zbirenbaum/copilot-cmp",
      enabled = false
    },
    {
      "folke/trouble.nvim",
      enabled = false
    },
    {
      "neoclide/coc.nvim",
      branch = "release",
      event = "BufEnter"
    }
  }
else
  return {}
end
