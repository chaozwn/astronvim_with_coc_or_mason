local is_available = require("astrocore").is_available

return {
  {
    "neoclide/coc.nvim",
    branch = "master",
    build = "npm ci",
    cmd = {
      "CocCommand",
      "CocConfig",
      "CocDiagnostics",
      "CocDisable",
      "CocEnable",
      "CocInfo",
      "CocInstall",
      "CocList",
      "CocLocalConfig",
      "CocOpenLog",
      "CocOutline",
      "CocPrintErrors",
      "CocRestart",
      "CocSearch",
      "CocStart",
      "CocUninstall",
      "CocUpdate",
      "CocUpdateSync",
      "CocWatch",
    },
    event = { "VimEnter" },
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.options then opts.options = {} end
        if not opts.options.g then opts.options.g = {} end
        if not opts.options.opt then opts.options.opt = {} end
        opts.options.opt.cmdheight = 1
        opts.options.g.coc_global_extensions = {
          "coc-json",
          "coc-marketplace",
          "coc-lua",
          "coc-tsserver",
          "coc-emmet",
          "coc-html",
          "coc-css",
          "coc-go",
          "coc-sh",
          "coc-sql",
          "coc-pyright",
          "coc-toml",
          "coc-prettier",
          "coc-snippets",
          "coc-pairs",
          "coc-highlight",
          "coc-eslint",
          "@yaegassy/coc-tailwindcss3",
          "coc-yaml",
          "@yaegassy/coc-volar"
        }
        -- Some servers have issues with backup files, see #649
        opts.options.opt.backup = false
        opts.options.opt.writebackup = false

        -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
        -- delays and poor user experience
        opts.options.opt.updatetime = 300
        opts.options.g.coc_snippet_next = "<C-n>"
        opts.options.g.coc_snippet_prev = "<C-p>"

        if not opts.commands then opts.commands = {} end
        opts.commands.Format = { function() vim.fn.CocAction "format" end, desc = "Format file with LSP" }
      end,
    },
  },
  {
    "honza/vim-snippets",
    event = "BufEnter",
  },
  -- disable core lsp plugins
  { "AstroNvim/astrolsp",                enabled = false },
  { "folke/neoconf.nvim",                enabled = false },
  { "folke/neodev.nvim",                 enabled = false },
  { "jay-babu/mason-null-ls.nvim",       enabled = false },
  { "neovim/nvim-lspconfig",             enabled = false },
  { "nvimtools/none-ls.nvim",            enabled = false },
  { "stevearc/aerial.nvim",              enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  -- cmp
  { "hrsh7th/cmp-buffer",                enabled = false },
  { "hrsh7th/cmp-nvim-lsp",              enabled = false },
  { "hrsh7th/cmp-path",                  enabled = false },
  { "hrsh7th/nvim-cmp",                  enabled = false },
  { "rcarriga/cmp-dap",                  enabled = false },
  { "saadparwaiz1/cmp_luasnip",          enabled = false },
  -- luaship
  { "L3MON4D3/LuaSnip",                  enabled = false },
  { "rafamadriz/friendly-snippets",      enabled = false },
  { "folke/neoconf.nvim",                enabled = false }
}
