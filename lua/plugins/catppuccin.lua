return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
      dim_inactive = {
        enabled = false,
      },
      show_end_of_buffer = true,
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
        notify = true,
        treesitter_context = true,
        treesitter = true,
        ts_rainbow2 = true,
        ts_rainbow = true,
        ufo = true,
        telescope = { enabled = true, style = "nvchad" },
        lsp_trouble = true,
        which_key = true,
        semantic_tokens = true,
        symbols_outline = true,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
