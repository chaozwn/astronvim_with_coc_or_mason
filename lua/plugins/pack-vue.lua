local is_vue_project = require("utils").is_vue_project

return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    ---@diagnostic disable-next-line: assign-type-mismatch
    opts = function(_, opts)
      local astrocore = require "astrocore"
      local volar_handler = opts.handlers.volar
      local vtsls_handler = opts.handlers.vtsls
      if not is_vue_project() then
        volar_handler = false
      else
        vtsls_handler = false
      end

      return astrocore.extend_tbl(opts, {
        ---@diagnostic disable: missing-fields
        handlers = {
          volar = volar_handler,
          vtsls = vtsls_handler,
        },
        config = {
          volar = {
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
            settings = {
              vue = {
                updateImportsOnFileMove = { enabled = true },
                server = {
                  maxOldSpaceSize = 8092,
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vue" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "volar" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "js" })
    end,
  },
}
