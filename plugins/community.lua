local lsp_type = require("user.config.lsp_type").lsp_type

local plugins = {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  -- 这个插件限制了hjkl连按次数和鼠标，强制学习vim操作
  -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/workflow/hardtime-nvim/hardtime-nvim.lua
  { import = "astrocommunity.workflow.hardtime-nvim" },
  -- { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
--   {
--     "akinsho/bufferline.nvim",
--     event = { "BufReadPost" },
--     opts = {
--       options = {
--         diagnostics = "nvim_lsp",      -- | "nvim_lsp" | "coc",
--         separator_style = "slant",
--         close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
--         diagnostics_indicator = function(count, _, _, _)
--           if count > 9 then
--             return "9+"
--           end
--           return tostring(count)
--         end,
--         offsets = {
--           {
--             filetype = "neo-tree",
--             text = "EXPLORER",
--             text_align = "center",
--             highlight = "Directory",
--           },
--         },
--         hover = {
--           enabled = true,
--           delay = 200,
--           reveal = { "close" },
--         },
--         color_icons = false,
--       },
--     },
--   },
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
