local lsp_type = require("user.config.lsp_type").lsp_type

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    opts.statusline[3] = status.component.file_info { filetype = {}, filename = false }

    function StatusDiagnostic()
      local info = vim.b.coc_diagnostic_info or {}
      if next(info) == nil then return '' end
      local msgs = {}
      if info.error and info.error > 0 then
        table.insert(msgs, 'E' .. info.error)
      end
      if info.warning and info.warning > 0 then
        table.insert(msgs, 'W' .. info.warning)
      end
      return table.concat(msgs, ' ') .. ' ' .. (vim.g.coc_status or '')
    end

    if lsp_type == "coc" then
      local LSPActive = {
        provider = function()
          return StatusDiagnostic()
        end,
        hl = { fg = "green", bold = true },
      }
      opts.statusline[9] = LSPActive
    end

    return opts
  end,
}
