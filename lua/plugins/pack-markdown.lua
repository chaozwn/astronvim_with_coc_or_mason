local utils = require "astrocore"
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        marksman = {
          on_attach = function(_, bufnr)
            if require("astrocore").is_available "markdown-preview.nvim" then
              require("astrocore").set_mappings {
                n = {
                  ["<Leader>lz"] = { "<Cmd>MarkdownPreview<CR>", desc = "Markdown Start Preview" },
                  ["<Leader>lZ"] = { "<Cmd>MarkdownPreviewStop<CR>", desc = "Markdown Stop Preview" },
                },
              }
            end
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "marksman" }) end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "prettierd" })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },
}
