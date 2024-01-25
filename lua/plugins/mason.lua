return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = require("astrocore").list_insert_unique(opts.registries, "github:mason-org/mason-registry")
    end,
  },
  { "jay-babu/mason-nvim-dap.nvim", optional = true, init = false },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  { "jay-babu/mason-null-ls.nvim", optional = true, opts = {} },
  { "nvimtools/none-ls.nvim", optional = true, opts = {} },
}
