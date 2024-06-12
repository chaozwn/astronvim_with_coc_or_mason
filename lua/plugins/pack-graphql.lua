return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = { "pylance" },
      ---@diagnostic disable: missing-fields
      config = {
        graphql = {
          root_dir = function(...)
            local util = require "lspconfig.util"
            return util.root_pattern(table.unpack {
              "*.graphql",
            })(...)
          end,
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      -- lsp
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "graphql" })
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, { name = "graphql" })
  --     return opts
  --   end,
  -- },
  -- {
  --   "phenax/cmp-graphql",
  --   dependencies = "hrsh7th/nvim-cmp",
  -- },
}
