if vim.g.lsp_type == "coc" then
  -- You NEED to override nvim-dap's default highlight groups, AFTER requiring nvim-dap
  require "dap"

  local sign = vim.fn.sign_define
  local utils = require "astronvim.utils"
  local get_icon = utils.get_icon

  sign("DapBreakpoint", { text = get_icon "DapBreakpoint", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
  sign(
    "DapBreakpointCondition",
    { text = get_icon "DapBreakpointCondition", texthl = "DiagnosticInfo", linehl = "", numhl = "" }
  )
  sign("DapLogPoint", { text = get_icon "DapLogPoint", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
  sign(
    "DapBreakpointRejected",
    { text = get_icon "DapBreakpointRejected", texthl = "DiagnosticError", linehl = "", numhl = "" }
  )
  sign("DapStopped", { text = get_icon "DapStopped", texthl = "DiagnosticWarn", linehl = "", numhl = "" })

  return {
    -- {
    --   "williamboman/mason.nvim",
    --   enabled = false
    -- },
    -- coc
    {
      "jose-elias-alvarez/null-ls.nvim",
      enabled = false,
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
      enabled = false,
    },
    -- dap
    -- {
    --   "mfussenegger/nvim-dap",
    --   enabled = false
    -- },
    -- WARNING: https://github.com/rcarriga/nvim-dap-ui/issues/260 close resize all buffer
    -- {
    --   "jay-babu/mason-nvim-dap.nvim",
    --   enabled = false,
    -- },
    -- {
    --   "mfussenegger/nvim-dap-python",
    --   enabled = false
    -- },
    -- WARNING: https://github.com/rcarriga/nvim-dap-ui/issues/260
    -- {
    --   "rcarriga/nvim-dap-ui",
    --   enabled = false
    -- },
    -- {
    --   "theHamsta/nvim-dap-virtual-text",
    --   enabled = false
    -- },
    {
      "rcarriga/cmp-dap",
      enabled = false,
    },
    -- refactor
    {
      "ThePrimeagen/refactoring.nvim",
      enabled = false,
    },
    -- luaship
    {
      "L3MON4D3/LuaSnip",
      enabled = false,
    },
    {
      "rafamadriz/friendly-snippets",
      enabled = false,
    },
    -- cmp
    {
      "hrsh7th/nvim-cmp",
      enabled = false,
    },
    {
      "hrsh7th/cmp-buffer",
      enabled = false,
    },
    {
      "hrsh7th/cmp-path",
      enabled = false,
    },
    {
      "saadparwaiz1/cmp_luasnip",
      enabled = false,
    },
    {
      "folke/trouble.nvim",
      enabled = false,
    },
    {
      "neoclide/coc.nvim",
      branch = "release",
      lazy = false,
    },
    {
      "honza/vim-snippets",
      dependencies = {
        "neoclide/coc.nvim",
      },
      event = "BufEnter",
    },
    {
      "folke/neoconf.nvim",
      enabled = false,
    },
  }
else
  return {}
end
