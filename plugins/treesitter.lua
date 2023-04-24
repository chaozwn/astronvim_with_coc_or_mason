-- :TSInstall lua
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {},
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      auto_install = true,
      ensure_installed = {
        "json",
        "html",
        "css",
        "vim",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "java",
      },
      sync_install = true,
    })
  end,
}
