local plugins = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  -- 这个插件限制了hjkl连按次数和鼠标，强制学习vim操作
  -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/workflow/hardtime-nvim/hardtime-nvim.lua
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
}

if vim.g.lsp_type ~= "coc" then
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
