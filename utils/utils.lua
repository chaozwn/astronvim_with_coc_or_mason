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

function M.is_vue_project()
  local package_json_path = vim.fn.getcwd() .. "/package.json"
  local file = io.open(package_json_path, "r")

  if file then
    local package_json_content = file:read "*a"
    file:close()

    local package_json = vim.fn.json_decode(package_json_content)

    if package_json and package_json.dependencies and package_json.dependencies.vue then return true end
  end

  return false
end

return M
