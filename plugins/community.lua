-- NOTE: insert mode :
-- <C-h> : delete previous character
-- <C-w> : delete previous word
-- <C-u> : delete to beginning of line
local plugins = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  -- 这个插件限制了hjkl连按次数和鼠标，强制学习vim操作
  -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/workflow/hardtime-nvim/hardtime-nvim.lua
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.editing-support.nvim-ts-rainbow2" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
}

if vim.g.lsp_type ~= "coc" then
  local lsp_plugins = {
    { import = "astrocommunity.pack.prisma" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.docker" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.json" },
  }
  for _, value in ipairs(lsp_plugins) do
    table.insert(plugins, value)
  end
end

return plugins
