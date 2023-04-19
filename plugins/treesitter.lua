-- :TSInstall lua
local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "p00f/nvim-ts-rainbow",
  },
  opts = {
    ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "python", "java" },
    sync_intsall = true,
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = rainbow,
      termcolors = rainbow,
    },
  },
}
