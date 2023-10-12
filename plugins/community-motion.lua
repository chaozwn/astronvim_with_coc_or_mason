-- TODO: check keys
return {
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  {
    "folke/flash.nvim",
    keys = function() return {} end,
  },
  { import = "astrocommunity.motion.marks-nvim" },
  {
    "chentoast/marks.nvim",
    opts = {
      default_mappings = false,
    },
  },
}
