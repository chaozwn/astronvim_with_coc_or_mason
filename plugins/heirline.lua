return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local utils = require "astronvim.utils"
    local extend_tbl = utils.extend_tbl

    function StatusDiagnostic(o)
      return function(self)
        ---@diagnostic disable-next-line: undefined-field
        local info = vim.b.coc_diagnostic_info or {}
        if next(info) == nil then return "" end
        local msgs = {}
        if info.error and info.error > 0 then table.insert(msgs, "E" .. info.error) end
        if info.warning and info.warning > 0 then table.insert(msgs, "W" .. info.warning) end
        return status.utils.stylize(table.concat(msgs, " ") .. " " .. (vim.g.coc_status or ""), o)
      end
    end

    local coc_lsp = {
      provider = StatusDiagnostic(),
      update = { "User", pattern = { "CocStatusChange", "CocDiagnosticChange" } },
      init = status.init.update_events { "User AstroFile" },
      callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
      hl = { fg = "green", bold = false },
      padding = { left = 1, right = 1 },
    }

    local file_encoding_component = function(o)
      o = extend_tbl {
        hl = status.hl.get_attributes "git_branch",
        provider = status.provider.file_encoding { padding = { left = 1 } },
      }
      return status.component.builder(status.utils.setup_providers(o, {}))
    end

    local file_format_component = function(o)
      o = extend_tbl({
        hl = status.hl.get_attributes "git_branch",
        provider = status.provider.file_format { padding = { left = 1 } },
      })
      return status.component.builder(status.utils.setup_providers(o, {}))
    end

    if vim.g.lsp_type == "coc" then
      -- TODO: 现在coc有bug，开启winbar会导致每次的cmd height + 1
      -- https://github.com/neoclide/coc.nvim/issues/4555
      opts.winbar = false
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
        coc_lsp,
        file_encoding_component(),
                file_format_component(),

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
        file_encoding_component(),
        file_format_component(),
        status.component.treesitter(),
        status.component.nav(),
      }
    end
    return opts
  end,
}
