local lsp_type = require("user.config.lsp_type").lsp_type

local plugins = {
  "AstroNvim/astrocommunity",
}

if lsp_type ~= 'coc' then
  plugins.insert(plugins, { import = "astrocommunity.pack.typescript" })
  plugins.insert(plugins, { import = "astrocommunity.pack.prisma" })
  plugins.insert(plugins, { import = "astrocommunity.pack.json" })
  plugins.insert(plugins, { import = "astrocommunity.pack.tailwindcss" })
  plugins.insert(plugins, { import = "astrocommunity.pack.markdown" })
  plugins.insert(plugins, { import = "astrocommunity.pack.python" })
  plugins.insert(plugins, { import = "astrocommunity.pack.java" })
end

return plugins

