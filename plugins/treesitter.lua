-- :TSInstall lua
-- NOTE: treesitter new textobject. k: block, c: class, ?: conditional, f: function, l: loop, a: parameter
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      auto_install = true,
      ensure_installed = {
        "go",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "json",
        "html",
        "css",
        "vim",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "toml",
        "markdown",
        "markdown_inline",
        "vue",
        "prisma",
      },
    })
  end,
}
