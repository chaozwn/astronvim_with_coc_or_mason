local M = {}

function M.better_search(key)
  return function()
    local searched, error =
        pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astronvim.utils").notify(error, vim.log.levels.ERROR) end
  end
end

function M.init_coc()
  require("astronvim.utils").notify('Initialized coc.nvim for LSP support', vim.log.levels.INFO, { title = "LSP Status" })
end

return M
