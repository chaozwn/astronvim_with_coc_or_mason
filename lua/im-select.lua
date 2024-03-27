local M = {}
local Mac = {}

-- update your self input method here
Mac.zhCN = "im.rime.inputmethod.Squirrel.Hans"
Mac.en =  "com.apple.keylayout.ABC"

local getChangeIM = function()
  local mode = vim.fn.mode()
  if mode == "n" then
    return Mac.en
  elseif mode == "i" then
    return Mac.zhCN
  elseif mode == "v" then
    return Mac.en
  else
    return Mac.en
  end
end

M.macFocusGained = function() vim.cmd(":silent :!im-select" .. " " .. getChangeIM()) end
M.macFocusLost = function() vim.cmd(":silent :!im-select" .. " " .. Mac.zhCN) end
M.macInsertLeave = function() vim.cmd(":silent :!im-select" .. " " .. Mac.en) end
M.macInsertEnter = function() vim.cmd(":silent :!im-select" .. " " .. Mac.zhCN) end

return M
