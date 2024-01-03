return {
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin",
    opts = {
      transparent_background = vim.g.transparent_background,
      integrations = {
        alpha = true,
        flash = true,
        gitsigns = true,
        markdown = true,
        neotree = true,
        mason = true,
        neogit = true,
        neotest = true,
        noice = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        notify = false,
        treesitter_context = true,
        treesitter = true,
        ts_rainbow2 = true,
        ts_rainbow = true,
        ufo = true,
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        which_key = true,
      },
    },
  },
}
