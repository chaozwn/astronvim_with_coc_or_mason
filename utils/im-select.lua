local M = {}
local Windows = {}
local Mac = {}

-- 使用这个autocmd的条件是使用mac输入法
local sougouIM = "com.sogou.inputmethod.sogou.pinyin"
local squirrelIM = "im.rime.inputmethod.Squirrel.Hans"
local defaultIM = "com.apple.keylayout.ABC"
Mac.zhCN = squirrelIM
Mac.en = defaultIM

Windows.pingyinIM = "2052"
Windows.englishIM = "1033"
Windows.leaveVimIM = Windows.englishIM

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

M.windowsFocusGained = function() vim.cmd(":silent :!~/.config/nvim/im-select.exe" .. " " .. Windows.leaveVimIM) end

M.windowsFocusLost = function()
  Windows.leaveVimIM = vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033"
  vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033"
end

M.windowsInsertLeave = function() vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033" end

M.windowsInsertEnter = function() vim.cmd ":silent :!~/.config/nvim/im-select.exe 2052" end
return M
