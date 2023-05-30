local lsp_type = require("user.config.lsp_type").lsp_type

local plugins = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
}

if lsp_type ~= "coc" then
  local lsp_plugins = {
    { import = "astrocommunity.pack.prisma" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.java" },
  }
  for _, value in ipairs(lsp_plugins) do
    table.insert(plugins, value)
  end
end

return plugins
