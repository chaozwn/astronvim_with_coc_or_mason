local lsp_type = require("user.config.lsp_type").lsp_type
if lsp_type == 'coc' then
  -- You NEED to override nvim-dap's default highlight groups, AFTER requiring nvim-dap
  require "dap"

  local sign = vim.fn.sign_define

  sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
end
return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      mocha = {
        base = "#181825",
        mantle = "#181825",
      },
    },
    custom_highlights = {},
    integrations = {
      nvimtree = false,
      ts_rainbow = true,
      aerial = true,
      dap = { enabled = true, enable_ui = true },
      headlines = true,
      mason = true,
      neotree = true,
      noice = true,
      notify = true,
      octo = true,
      sandwich = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      which_key = true,
      leap = true,
      coc_nvim = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
  },
}
