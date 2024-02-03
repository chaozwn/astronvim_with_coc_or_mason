return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, "proto")
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, "bufls")
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, "buf")

      opts.handlers.buf = function()
        local null_ls = require "null-ls"
        null_ls.register(null_ls.builtins.diagnostics.buf.with {
          condition = function() return false end,
        })
        null_ls.register(null_ls.builtins.formatting.buf.with {
          condition = function() return true end,
        })
      end
    end,
  },
}
