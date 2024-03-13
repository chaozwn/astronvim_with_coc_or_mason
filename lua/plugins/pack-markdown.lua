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
                  ["<Leader>lp"] = { "<Cmd>Pastify<CR>", desc = "Markdown Paste Image" },
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "marksman", "prettierd" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "TobinPalmer/pastify.nvim",
    cmd = { "Pastify" },
    opts = {
      absolute_path = false,
      apikey = "",
      local_path = "/assets/imgs/",
      save = "local",
    },
  },
}
