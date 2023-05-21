local lsp_util = require "lspconfig.util"
return {
  root_dir = function(fname) return lsp_util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname) end,
}
