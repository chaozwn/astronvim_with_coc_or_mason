return {
  mappings = function(maps) return require("user.keymaps").mappings(maps) end,
  diagnostics = {
    update_in_insert = false,
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    underline = true,
    signs = { severity = { min = vim.diagnostic.severity.WARN } },
  },
  lazy = {
    -- spec = {
    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    -- { import = "lazyvim.plugins.extras.editor.navic" },
    -- { import = "lazyvim.plugins.extras.editor.aerial" },
    -- { import = "lazyvim.plugins.extras.editor.symbols-outline" },
    -- { import = "lazyvim.plugins.extras.dap.core" },
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- { import = "lazyvim.plugins.extras.lang.docker" },
    -- { import = "lazyvim.plugins.extras.lang.go" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.lang.markdown" },
    -- { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.yaml" },
    -- { import = "lazyvim.plugins.extras.linting.eslint" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    -- import/override with your plugins
    -- { import = "plugins" },
    -- },
    defaults = { lazy = false },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = {
          "tohtml",
          "gzip",
          "matchit",
          "zipPlugin",
          "netrwPlugin",
          "tarPlugin",
          "null-ls.nvim",
          "jay-babu/mason-null-ls.nvim",
          "jose-elias/null-ls.nvim",
        },
      },
    },
  },
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright",
      -- "tsserver",
      -- "astro",
    },
    -- capabilities = {
    --   workspace = {
    --     applyEdit = true,
    --     workspaceEdit = {
    --       documentChanges = true,
    --       resourceOperations = {
    --         "create",
    --         "rename",
    --         "delete",
    --       },
    --       failureHandling = "textOnlyTransactional",
    --     },
    --     didChangeConfiguration = {
    --       dynamicRegistration = true,
    --     },
    --     didChangeWatchedFiles = {
    --       dynamicRegistration = true,
    --     },
    --   },
    --   textDocument = {
    --     completion = {
    --       completionItem = {
    --         snippetSupport = true,
    --       },
    --     },
    --   },
  },
}
