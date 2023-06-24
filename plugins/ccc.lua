return {
  { "NvChad/nvim-colorizer.lua", enabled = false },
  {
    "uga-rosa/ccc.nvim",
    event = "User AstroFile",
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  },
}
