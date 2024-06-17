---@type LazySpec
return {
  { "Bekaboo/dropbar.nvim", event = "UIEnter", opts = {} },
  {
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts)
      opts.winbar = nil
    end,
  },
}
