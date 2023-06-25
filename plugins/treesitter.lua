-- :TSInstall lua
-- NOTE: https://github.com/AstroNvim/AstroNvim/commit/377db3f7d6273779533c988dadc07a08e0e43f2e new textobject
-- NOTE: treesitter new textobject. k: block, c: class, ?: conditional, f: function, l: loop, a: parameter, ""< | > | A ,F ,K" swap textobject
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, { })
  end,
}
