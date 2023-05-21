local lsp_util = require "lspconfig/util"

return {
  root_dir = function() lsp_util.root_pattern("unocss.config.js", "unocss.config.ts", "uno.config.js", "uno.config.ts") end,
  filetypes = { "html", "javascriptreact", "javascript", "typescript", "typescriptreact", "vue", "svelte" },
  on_attach = function(client, bufnr) client.server_capabilities.documentHighlightProvider = false end,
}
