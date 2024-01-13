return {
  {
    "smjonas/inc-rename.nvim",
    event = "User AstroLspSetup",
    dependencies = {
      "AstroNvim/astrolsp",
      opts = {
        mappings = {
          n = {
            ["<Leader>lr"] = {
              ":IncRename ",
              desc = "IncRename",
            },
          },
        },
      },
    },
    cmd = "IncRename",
    opts = {},
  },
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      presets = {
        inc_rename = true,
      },
    },
  },
}
