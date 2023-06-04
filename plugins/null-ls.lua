return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      null_ls.builtins.code_actions.eslint_d.with {
        -- js/ts linter
        -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
        condition = function(utils)
          return utils.root_has_file ".eslintrc.js"
            or utils.root_has_file ".eslintrc.cjs"
            or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
        end,
      },
      -- Set a formatter
      null_ls.builtins.formatting.eslint_d.with {
        -- js/ts linter
        -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
        condition = function(utils)
          return utils.root_has_file ".eslintrc.js"
            or utils.root_has_file ".eslintrc.cjs"
            or utils.root_has_file ".eslintrc.json" -- change file extension if you use something else
        end,
      },
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "css",
          "astro",
          "tsx",
          "scss",
          "less",
          "html",
          "json",
          "yaml",
          "markdown",
          "graphql",
        },
      },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.isort.with {
        filetypes = { "python" },
      },
    }
    return config -- return final config table
  end,
}
