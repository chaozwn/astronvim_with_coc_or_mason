-- :TSInstall lua
-- NOTE: treesitter new textobject. k: block, c: class, ?: conditional, f: function, l: loop, a: parameter, ""< | > | a ,f ,k" swap textobject
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      auto_install = true,
      ensure_installed = {
        "http",
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
      rainbow = {
        enable = true,
      },
      highlight = {
        enable = true,
        --disable = function(lang, buf)
        --    local max_filesize = 100 * 1024 -- 100 KB
        --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --    if ok and stats and stats.size > max_filesize then
        --        return true
        --    end
        --end,
        additional_vim_regex_highlighting = { "markdown", "yaml" },
      },
    })
  end,
}
