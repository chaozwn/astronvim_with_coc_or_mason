-- NOTE: insert mode :
-- <C-h> : delete previous character
-- <C-w> : delete previous word
-- <C-u> : delete to beginning of line
local plugins = {
  "AstroNvim/astrocommunity",
  -- 这个插件限制了hjkl连按次数和鼠标，强制学习vim操作
  -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/workflow/hardtime-nvim/hardtime-nvim.lua
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
}

if vim.g.lsp_type ~= "coc" then
  local lsp_plugins = {
    { import = "astrocommunity.pack.prisma" },
    { import = "astrocommunity.pack.typescript-all-in-one" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.docker" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.html-css" },
    -- WARNING:support native inlay hints.
    -- https://github.com/AstroNvim/AstroNvim/pull/2015/commits/9b9d565afb7dfb733e772b4f16dcd1069b0afc71
    -- WARNING: astronvim support native inlay hints
    -- https://github.com/AstroNvim/AstroNvim/commit/14ba29cec669f8a294fc7ef1ae78ae3f91246940
    -- TODO: wait nvim update to 0.10, we can upgrade this plugin.
    { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
  }
  for _, value in ipairs(lsp_plugins) do
    table.insert(plugins, value)
  end
end

return plugins
