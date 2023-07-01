return {
  { import = "astrocommunity.completion.copilot-lua" },
  {
    "uga-rosa/ccc.nvim",
    keys = function() return {} end,
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  },
}
