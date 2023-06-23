return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local coc_diagnostic = require "user.config.component".coc_diagnostic
    local coc_lsp = require "user.config.component".coc_lsp

    if vim.g.lsp_type == "coc" then
      -- WARNING: 现在coc有bug，开启winbar会导致每次的cmd height + 1
      -- https://github.com/neoclide/coc.nvim/issues/4555
      -- opts.winbar = false
      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        coc_diagnostic(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        coc_lsp(),
        status.component.treesitter(),
        status.component.nav(),
      }
    else
      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
        status.component.git_branch(),
        status.component.file_info { filetype = {}, filename = false, file_modified = false },
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.treesitter(),
        status.component.nav(),
      }
    end
    return opts
  end,
}
