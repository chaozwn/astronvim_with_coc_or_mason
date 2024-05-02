local utils = require "astrocore"
local is_available = require("astrocore").is_available
local set_mappings = require("astrocore").set_mappings

return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        taplo = {
          evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } },
          on_attach = function(_, bufnr)
            set_mappings({
              n = {
                ["K"] = {
                  function()
                    if vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
                      require("crates").show_popup()
                    else
                      vim.lsp.buf.hover()
                    end
                  end,
                  desc = "Show Crate Documentation",
                },
              },
            }, { buffer = bufnr })
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "toml" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "taplo" }) end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.handlers exists and is a table
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.taplo = function() end
    end,
  },
}
