local lsp_type = require("user.config.lsp_type").lsp_type

local plugins = {
  "AstroNvim/astrocommunity",
}

if lsp_type ~= "coc" then
  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.prisma" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.java" },
  }
end

return plugins
