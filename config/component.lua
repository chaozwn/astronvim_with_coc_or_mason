local utils = require "astronvim.utils"
local status = require "astronvim.utils.status"
local hl = status.hl
local component = status.component
local is_available = utils.is_available
local provider = require "user.config.provider"
local condition = require "user.config.condition"
local M = {}

function M.coc_diagnostic(opts)
  local diagnostic_componets = {}
  local servertiys = { "Error", "Warn", "Info", "Hint" }
  -- 带索引遍历servertiys
  for i, servertiy in ipairs(servertiys) do
    diagnostic_componets[i] = {
      provider = provider.coc_diagnostic({
        servertiy = servertiy:upper(),
        icon = { kind = "Diagnostic" .. servertiy, padding = { left = 1, right = 1 } },
      }),
      hl = { fg = "diag_" .. servertiy:upper() },
      surround = { separator = "left", color = "diagnostics_bg", condition = condition.has_coc_diagnostics },
      on_click = {
        name = "heirline_diagnostic",
        callback = function()
          if is_available "telescope.nvim" then
            if is_available "telescope-coc.nvim" then
              vim.defer_fn(function()
                require("telescope").extensions.coc.diagnostics()
              end, 100)
            end
          end
        end,
      },
      update = { "User", pattern = { "CocDiagnosticChange" } },
    }
  end

  return component.builder(diagnostic_componets)
end

function M.coc_lsp(opts)
  local lsp_component = {
    {
      provider = provider.coc_lsp(
        { icon = { kind = "ActiveLSP", padding = { right = 2 } } }
      ),
      surround = { separator = "right", color = "lsp_bg", condition = condition.coc_lsp_attached },
      hl = hl.get_attributes "lsp",
      update = { "User", pattern = { "CocStatusChange" } },
      on_click = {
        name = "coc_status",
        callback = function()
          if is_available "coc.nvim" then
            vim.defer_fn(function()
              vim.api.nvim_command "CocList services"
            end, 100)
          end
        end,
      },
    }
  }
  return component.builder(lsp_component)
end

return M
