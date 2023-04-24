-- User AstroFile : Triggered after opening a file
-- VeryLazy : Triggered after opening a file
-- BufEnter *.lua : Triggered after opening a Lua file
-- InsertEnter : Triggered after entering insert mode
-- LspAttach : Triggered after staring LSPs
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- Lua
  ------------------------ 多窗口聚焦提示 -------------------
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinNew",
    opts = {},
  },
  ----------------------- synthwave84 ----------------------
  -- {
  --   "lunarvim/synthwave84.nvim",
  --   opts = {
  --     glow = {
  --       error_msg = true,
  --       type2 = true,
  --       func = true,
  --       keyword = true,
  --       operator = true,
  --       buffer_current_target = true,
  --       buffer_visible_target = true,
  --       buffer_inactive_target = true,
  --     },
  --   },
  -- },
}
