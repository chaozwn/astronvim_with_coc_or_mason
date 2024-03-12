if vim.fn.has "nvim-0.10" == 0 then
  return {}
else
  return {
    { "Bekaboo/dropbar.nvim", event = "UIEnter", opts = {} },
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts) opts.winbar = nil end,
    },
  }
end
