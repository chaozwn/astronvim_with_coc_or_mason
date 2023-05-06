local util = require "lspconfig/util"

return {
  cmd = { "unocss-language-server", "--stdio" },
  root_dir = util.root_pattern("unocss.config.js", "unocss.config.ts", "uno.config.js", "uno.config.ts"),
  filetypes = { "html", "javascriptreact", "rescript", "typescriptreact", "vue", "svelte" },
}
