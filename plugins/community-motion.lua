-- TODO: check keys
return {
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  -- NOTE: fix(char): never add mappings for mapleader and maplocalleader.
  -- {
  --   "folke/flash.nvim",
  --   commit = "6e3dab6b011bb7661b16e14dd4aa4215894c9291",
  --   keys = function() return {} end,
  -- },
  -- NOTE: chore(main): release 1.17.0 (#148)
  {
    "folke/flash.nvim",
    commit = "610ade978c816f1d6156ca4ffafc2c4b8c70909c",
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
