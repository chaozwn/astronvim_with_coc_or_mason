local util = require "lspconfig/util"

return {
  root_dir = util.root_pattern("unocss.config.js", "unocss.config.ts", "uno.config.js", "uno.config.ts"),
  filetypes = { "html", "javascriptreact", "rescript", "typescriptreact", "vue", "svelte" },
  on_attach = function(client, bufnr) client.server_capabilities.documentHighlightProvider = false end,
}
