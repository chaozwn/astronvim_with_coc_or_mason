local utils = require "astrocore"
local markdown_table_change = function()
  vim.ui.input({ prompt = "Separate Char: " }, function(input)
    if not input or #input == 0 then return end
    local execute_command = ([[:'<,'>MakeTable! ]] .. input)
    vim.cmd(execute_command)
  end)
end
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
                x = {
                  ["<Leader>lt"] = { [[:'<,'>MakeTable! \t<CR>]], desc = "Markdown csv to table(Default:\\t)" },
                  ["<Leader>lT"] = { markdown_table_change, desc = "Markdown csv to table with separate char" },
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
