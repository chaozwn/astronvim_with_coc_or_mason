return {
  "petertriho/cmp-git",
  ft = { "gitcommit", "octo", "NeogitCommitMessage" },
  dependencies = { "hrsh7th/nvim-cmp" },
  opts = function(plugin, opts)
    opts.filetypes = require("lazy.core.plugin").values(assert(require("astrocore").get_plugin(plugin.name)), "ft")
  end,
  config = function(_, opts)
    local cmp = require "cmp"
    if opts.filetypes then
      cmp.setup.filetype(opts.filetypes, {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        }),
      })
    end
    require("cmp_git").setup(opts)
  end,
}
