-- TODO: check keys
return {
  -- NOTE: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/motion/mini-surround/init.lua key mappings description
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  {
    "folke/flash.nvim",
    keys = function() return {} end,
  },
}
