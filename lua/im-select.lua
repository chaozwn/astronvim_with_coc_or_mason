local M = {}
local Mac = {}

-- 使用这个autocmd的条件是使用mac输入法
Mac.zhCN = "im.rime.inputmethod.Squirrel.Hans"
Mac.en =  "com.apple.keylayout.ABC"

local getChangeIM = function()
  local mode = vim.fn.mode()
  if mode == "n" then
    -- 当前是 normal 模式
    return Mac.en
  elseif mode == "i" then
    -- 当前是 insert 模式
    return Mac.zhCN
  elseif mode == "v" then
    -- 当前是 visual 模式
    return Mac.en
  else
    -- 当前不是 normal、insert 或 visual 模式
    return Mac.en
  end
end

M.macFocusGained = function() vim.cmd(":silent :!im-select" .. " " .. getChangeIM()) end
M.macFocusLost = function() vim.cmd(":silent :!im-select" .. " " .. Mac.zhCN) end
M.macInsertLeave = function() vim.cmd(":silent :!im-select" .. " " .. Mac.en) end
M.macInsertEnter = function() vim.cmd(":silent :!im-select" .. " " .. Mac.zhCN) end

return M
