return {
  "b0o/incline.nvim",
  dependencies = {
    "catppuccin",
  },
  event = "BufEnter",
  opts = function(_, opts)
    local palette = require("catppuccin.palettes").get_palette()
    return require("astronvim.utils").extend_tbl(opts, {
      highlight = {
        groups = {
          InclineNormal = { guifg = palette.mantle, guibg = palette.blue, gui = "bold" },
          InclineNormalNC = { guibg = palette.surface0, guifg = palette.blue },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if vim.bo[props.buf].modified then filename = "[+] " .. filename end

        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        return { { icon, guifg = color }, { " " }, { filename } }
      end,
    })
  end,
}
