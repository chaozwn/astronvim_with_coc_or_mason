local M = {}

function M.better_search(key)
  return function()
    local searched, error =
        pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astronvim.utils").notify(error, vim.log.levels.ERROR) end
  end
end

function M.is_mac()
  return function()
    local system = vim.loop.os_uname().sysname
    if system == "Darwin" then
      return true
    else
      return false
    end
  end
end

function M.get_os()
  -- NOTE: mac system both return 1 in ('mac','unix')
  -- get the current OS
  local os
  if vim.fn.has "mac" == 1 then
    os = "mac"
  elseif vim.fn.has "unix" == 1 then
    os = "linux"
  elseif vim.fn.has "win32" == 1 then
    os = "win"
  else
    require("astronvim.utils").notify("not valid os", vim.log.levels.ERROR)
  end
  return os
end

function M.init_coc()
  require("astronvim.utils").notify(
    "Initialized coc.nvim for LSP support",
    vim.log.levels.INFO,
    { title = "LSP Status" }
  )
end

return M
