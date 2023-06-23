local M = {}

function M.has_coc_diagnostics()
    return vim.b.coc_diagnostic_info and vim.b.coc_diagnostic_info.error > 0
        or vim.b.coc_diagnostic_info and vim.b.coc_diagnostic_info.warning > 0
        or vim.b.coc_diagnostic_info and vim.b.coc_diagnostic_info.information > 0
        or vim.b.coc_diagnostic_info and vim.b.coc_diagnostic_info.hint > 0
end

function M.coc_lsp_attached()
    return vim.g.coc_status ~= nil and vim.g.coc_status ~= ""
end

return M
