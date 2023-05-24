local lsp_type = require("user.config.lsp_type").lsp_type
local community = {
 "AstroNvim/astrocommunity",
}
if lsp_type == 'coc' then
else
 community = {
  -- Add the community repository of plugin specifications
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.java" },
 }
end


return community
