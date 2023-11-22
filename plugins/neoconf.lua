return {
  "folke/neoconf.nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      import = {
        vscode = true,
        coc = false,
        nlsp = true,
      },
    })
  end,
}
