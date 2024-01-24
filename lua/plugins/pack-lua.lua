local utils = require "astrocore"
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "lua", "luap")
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "lua_ls") end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      -- format
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "stylua")
      -- lint
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "luacheck")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@diagnostic disable: missing-fields
    ---@type AstroLSPOpts
    opts = {
      config = {
        lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      },
    },
  },
}
