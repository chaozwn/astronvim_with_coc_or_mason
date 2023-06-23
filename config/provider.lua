local status = require "astronvim.utils.status"
local status_utils = status.utils

local M = {}

function M.coc_diagnostic(opts)
  if not opts or not opts.servertiy then return end
  return function(self)
    local servertiy = opts.servertiy
    local count = ""
    local coc_status = vim.b.coc_diagnostic_info or { error = 0, warning = 0, information = 0, hint = 0 }
    if servertiy == "ERROR" then
      local error = coc_status.error
      count = error ~= 0 and tostring(error) or ""
    elseif servertiy == "WARN" then
      local warning = coc_status.warning
      count = warning ~= 0 and tostring(warning) or ""
    elseif servertiy == "INFO" then
      local info = coc_status.information
      count = info ~= 0 and tostring(info) or ""
    elseif servertiy == "HINT" then
      local hint = coc_status.hint
      count = hint ~= 0 and tostring(hint) or ""
    end
    return status_utils.stylize(count, opts)
  end
end

function M.coc_lsp(opts)
  return function(self)
    local servers = ""
    if vim.g.coc_status ~= nil and vim.g.coc_status ~= "" then
      if string.find(vim.g.coc_status, "Lua") then
        servers = "Lua"
      else
        servers = vim.g.coc_status
      end
    end
    return status_utils.stylize(servers, opts)
  end
end

return M
