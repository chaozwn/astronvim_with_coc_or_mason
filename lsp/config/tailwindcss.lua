return {
  root_dir = function(fname)
    local lsp_util = require "lspconfig.util"
    return lsp_util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
  end,
}
