return {
  "nvimtools/none-ls.nvim",
  -- event = "LazyFile",
  dependencies = { "mason.nvim" },
  -- init = function()
  --   -- Util.on_very_lazy(function()
  --     -- register the formatter with LazyVim
  --     require("lazyvim.util").format.register {
  --       name = "none-ls.nvim",
  --       priority = 200, -- set higher than conform, the builtin formatter
  --       primary = true,
  --       format = function(buf)
  --         return Util.lsp.format {
  --           bufnr = buf,
  --           filter = function(client) return client.name == "null-ls" end,
  --         }
  --       end,
  --       sources = function(buf)
  --         local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
  --         return vim.tbl_map(function(source) return source.name end, ret)
  --       end,
  --     }
  --   -- end)
  -- end,
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.shfmt,
      nls.builtins.code_actions.eslint_d.with {
        -- js/ts linter
        -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
        filetypes = {
          "css",
          "astro",
          "svelte",
          "tsx",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "markdown",
          "graphql",
        },

        condition = function(utils)
          return utils.root_has_file ".eslintrc.js"
            or utils.root_has_file ".eslintrc.cjs"
            or utils.root_has_file ".eslintrc.mjs"
            or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
        end,
      },
      -- Set a formatter
      nls.builtins.formatting.eslint_d.with {
        -- js/ts linter
        -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
        filetypes = {
          "css",
          "astro",
          "svelte",
          "tsx",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "markdown",
          "graphql",
        },

        condition = function(utils)
          return utils.root_has_file ".eslintrc.js"
            or utils.root_has_file ".eslintrc.cjs"
            or utils.root_has_file ".eslintrc.mjs"
            or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
        end,
      },

    })
  end,
  -- "jose-elias-alvarez/null-ls.nvim",
  -- opts = function(_, opts)
  --   -- config variable is the default configuration table for the setup function call
  --   local null_ls = require "null-ls"
  --
  --   -- Check supported formatters and linters
  --   -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  --   -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  --   opts.sources = {
  --     null_ls.builtins.code_actions.eslint_d.with {
  --       -- js/ts linter
  --       -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
  --       filetypes = {
  --         "css",
  --         "astro",
  --         "svelte",
  --         "tsx",
  --         "scss",
  --         "less",
  --         "html",
  --         "json",
  --         "yaml",
  --         "markdown",
  --         "graphql",
  --       },
  --
  --       condition = function(utils)
  --         return utils.root_has_file ".eslintrc.js"
  --           or utils.root_has_file ".eslintrc.cjs"
  --           or utils.root_has_file ".eslintrc.mjs"
  --           or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
  --       end,
  --     },
  --     -- Set a formatter
  --     null_ls.builtins.formatting.eslint_d.with {
  --       -- js/ts linter
  --       -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
  --       filetypes = {
  --         "css",
  --         "astro",
  --         "svelte",
  --         "tsx",
  --         "scss",
  --         "less",
  --         "html",
  --         "json",
  --         "yaml",
  --         "markdown",
  --         "graphql",
  --       },
  --
  --       condition = function(utils)
  --         return utils.root_has_file ".eslintrc.js"
  --           or utils.root_has_file ".eslintrc.cjs"
  --           or utils.root_has_file ".eslintrc.mjs"
  --           or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
  --       end,
  --     },
  --     -- null_ls.builtins.formatting.prettierd.with {
  --     --   filetypes = {
  --     --     "css",
  --     --     "astro",
  --     --     "svelte",
  --     --     "tsx",
  --     --     "scss",
  --     --     "less",
  --     --     "html",
  --     --     "json",
  --     --     "yaml",
  --     --     "markdown",
  --     --     "graphql",
  --     --   },
  --     --   -- extra_filetypes = { "astro" },
  --     -- },
  --     -- null_ls.builtins.formatting.prettier.with {
  --     --   filetypes = {
  --     --     "css",
  --     --     "astro",
  --     --     "svelte",
  --     --     "tsx",
  --     --     "scss",
  --     --     "less",
  --     --     "html",
  --     --     "json",
  --     --     "yaml",
  --     --     "markdown",
  --     --     "graphql",
  --     --   },
  --     --   -- extra_filetypes = { "astro" },
  --     -- },
  --
  --     null_ls.builtins.formatting.stylua,
  --     null_ls.builtins.formatting.isort.with {
  --       filetypes = { "python" },
  --     },
  --   }
  --   return opts -- return final config table
  -- end,
  -- opts = function(_, opts) return opts end,
}
