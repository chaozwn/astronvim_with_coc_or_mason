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
  --   config = function() require("lsp_signature").setup() end,
  -- },
  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      terminal_mappings = false,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame_opts = { ignore_whitespace = true },
    },
  },
}
