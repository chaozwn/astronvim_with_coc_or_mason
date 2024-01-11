return {
  "folke/neoconf.nvim",
  cmd = "Neoconf",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      -- name of the local settings files
      local_settings = ".neoconf.json",
      -- name of the global settings file in your Neovim config directory
      global_settings = "neoconf.json",
      import = {
        vscode = true,
        coc = true,
        nlsp = true,
      },
    })
  end,
}
