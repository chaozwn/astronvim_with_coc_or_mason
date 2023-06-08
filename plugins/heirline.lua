return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"

    function StatusDiagnostic()
      ---@diagnostic disable-next-line: undefined-field
      local info = vim.b.coc_diagnostic_info or {}
      if next(info) == nil then return "" end
      local msgs = {}
      if info.error and info.error > 0 then table.insert(msgs, "E" .. info.error) end
      if info.warning and info.warning > 0 then table.insert(msgs, "W" .. info.warning) end
      return table.concat(msgs, " ") .. " " .. (vim.g.coc_status or "")
    end

    local coc_lsp = {
      provider = function() return StatusDiagnostic() end,
      update = { "User", pattern = { "CocStatusChange", "CocDiagnosticChange" } },
      init = status.init.update_events { 'User AstroFile' },
      callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
      hl = { fg = "green", bold = false },
    }

    if vim.g.lsp_type == "coc" then
      opts.statusline[9] = coc_lsp
    end
  end,
}
