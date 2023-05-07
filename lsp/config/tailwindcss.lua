return {
  lsp = {
    config = {
      tailwindcss = {
        root_dir = function(fname)
          local util = require "lspconfig.util"
          return util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
        end,
      },
    },
  },
}
