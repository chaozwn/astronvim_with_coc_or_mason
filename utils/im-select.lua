local M = {}
local Windows = {}

-- 使用这个autocmd的条件是使用mac输入法
M.sougouIM = "com.sogou.inputmethod.sogou.pinyin"
M.defaultIM = "com.apple.keylayout.ABC"
M.leaveVimIM = M.defaultIM

Windows.pingyinIM = "2052"
Windows.englishIM = "1033"
Windows.leaveVimIM = Windows.englishIM

M.macFocusGained = function() vim.cmd(":silent :!im-select" .. " " .. M.leaveVimIM) end

M.macFocusLost = function()
  M.leaveVimIM = vim.fn.system { "im-select" }
  vim.cmd(":silent :!im-select" .. " " .. M.sougouIM)
end

M.macInsertLeave = function() vim.cmd(":silent :!im-select" .. " " .. M.defaultIM) end

M.macInsertEnter = function() vim.cmd(":silent :!im-select" .. " " .. M.sougouIM) end

M.windowsFocusGained = function() vim.cmd(":silent :!~/.config/nvim/im-select.exe" .. " " .. Windows.leaveVimIM) end

M.windowsFocusLost = function()
  Windows.leaveVimIM = vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033"
  vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033"
end

M.windowsInsertLeave = function() vim.cmd ":silent :!~/.config/nvim/im-select.exe 1033" end

M.windowsInsertEnter = function() vim.cmd ":silent :!~/.config/nvim/im-select.exe 2052" end
return M
