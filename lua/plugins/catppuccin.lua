---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      custom_highlights = {
        -- disable italics  for treesitter highlights
        TabLineFill = { link = "StatusLine" },
        LspInlayHint = { style = { "italic" } },
        UfoFoldedEllipsis = { link = "UfoFoldedFg" },
        ["@parameter"] = { style = {} },
        ["@type.builtin"] = { style = {} },
        ["@namespace"] = { style = {} },
        ["@text.uri"] = { style = { "underline" } },
        ["@tag.attribute"] = { style = { "italic" } },
        ["@tag.attribute.tsx"] = { style = { "italic" } },
      },
    },
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    },
  },
}
