return {
  "jose-elias-alvarez/null-ls.nvim",
  enabled = false,
  -- event = "LazyFile",
  dependencies = { "mason.nvim" },
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
}
