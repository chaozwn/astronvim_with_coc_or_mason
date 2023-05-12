return {
  "onsails/lspkind.nvim",
  opts = function(_, opts)
    opts.preset = "codicons"
    opts.symbol_map = require ("user.config.icon").kinds
    return opts
  end,
}
