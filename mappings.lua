-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
local is_available = utils.is_available

local maps = { i = {}, n = {}, v = {}, t = {}, c = {} }

maps.n["s"] = "<Nop>"

-- $跳到行尾不带空格(交换$和g_)
maps.n["$"] = { "g_", desc = "Go to end without blank" }
maps.n["g_"] = { "$", desc = "Go to end" }
maps.v["$"] = { "g_", desc = "Go to end without blank" }
maps.v["g_"] = { "$", desc = "Go to end" }
maps.n["0"] = { "^", desc = "Go to start without blank" }
maps.n["^"] = { "0", desc = "Go to start" }
maps.v["0"] = { "^", desc = "Go to start without blank" }
maps.v["^"] = { "0", desc = "Go to start" }

-- 命令行下 Ctrl + j/k 上一个下一个
--maps.c["<C-j>"] = { "<C-n>", desc = "Next option" }
--maps.c["<C-k>"] = { "<C-p>", desc = "Prev option" }

-- 保存文件
-- maps.n["<leader>wq"] = { ":wqa!<CR>", desc = "Save and Exit" }

-- 上下滚动5行
-- maps.n["<C-j>"] = { "5j", desc = "Move down 5 lines" }
-- maps.n["<C-k>"] = { "5k", desc = "Move up 5 lines" }
-- maps.v["<C-j>"] = { "5j", desc = "Move down 5 lines" }
-- maps.v["<C-k>"] = { "5k", desc = "Move up 5 lines" }

-- 上下滚动10行
maps.n["<C-u>"] = { "10k", desc = "Move down 10 lines" }
maps.n["<C-d>"] = { "10j", desc = "Move up 10 lines" }
maps.v["<C-u>"] = { "10k", desc = "Move down 10 lines" }
maps.v["<C-d>"] = { "10j", desc = "Move up 10 lines" }

-- 开启魔术搜索,即可以通过正则来搜索
maps.n["/"] = { "/\\v", desc = "magic search" }
maps.v["/"] = { "/\\v", desc = "magic search" }

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
maps.v["<"] = { "<gv", desc = "indent to the left" }
maps.v[">"] = { ">gv", desc = "indent to the right" }

-- 上下移动选中文本
maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "move selected one line up" }
maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "move selected one line down" }

-- 在visual mode 里粘贴不要复制
-- maps.v["p"] = { '"_dP', desc = "paste without copy" }
maps.n["x"] = { '"_x', desc = "cut without copy" }

-- 关闭搜索高亮
maps.n["<leader>nh"] = { ":nohlsearch<CR>", desc = "close search highlight" }

-- 分屏快捷键
-- maps.n["s"] = { "", desc = "do nothing" }
-- maps.n["sv"] = { ":vsp<CR>", desc = "split vertical screen" }
-- maps.n["sh"] = { ":sp<CR>", desc = "split horizontal screen" }
-- maps.n["sc"] = { "<C-w>c", desc = "close current screen" }
maps.n["<leader>bw"] = { "<C-w>c", desc = "close current screen" }
-- maps.n["so"] = { "<C-w>o", desc = "close other screen" }
maps.n["<leader>bo"] = { "<C-w>o", desc = "close other screen" }
-- 多个窗口之间跳转
-- maps.n["<C-S-h>"] = { "<C-w>h", desc = "jump to left screen" }
-- maps.n["<C-S-j>"] = { "<C-w>j", desc = "jump to down screen" }
-- maps.n["<C-S-k>"] = { "<C-w>k", desc = "jump to up screen" }
-- maps.n["<C-S-l>"] = { "<C-w>l", desc = "jump to right screen" }
-- 调整窗口大小
-- maps.n["<C-S-]>"] = { ":vertical resize -2<CR>", desc = "decrease screen left margin" }
-- maps.n["<C-S-[>"] = { ":vertical resize +2<CR>", desc = "increase screen left width" }
-- maps.n["<C-S-->"] = { ":resize -2<CR>", desc = "increase screen top margin" }
-- maps.n["<C-S-=>"] = { ":resize +2<CR>", desc = "decrease screen top margin" }
-- maps.n["s]"] = { ":vertical resize -2<CR>", desc = "decrease screen left margin" }
-- maps.n["s["] = { ":vertical resize +2<CR>", desc = "increase screen left width" }
-- maps.n["s-"] = { ":resize -2<CR>", desc = "increase screen top margin" }
-- maps.n["s="] = { ":resize +2<CR>", desc = "decrease screen top margin" }
-- maps.n["s="] = { "<C-w>=", desc = "make all window equal" }
maps.n["<leader>b="] = { "<C-w>=", desc = "make all window equal" }

-- 搜索到自动居中
maps.n["n"] = { "nzz", desc = "show next and center" }
maps.n["N"] = { "Nzz", desc = "show next and center" }
maps.v["n"] = { "nzz", desc = "show next and center" }
maps.v["N"] = { "Nzz", desc = "show next and center" }

-- Comment
if is_available "Comment.nvim" then
  maps.n["<C-/>"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
  }
  maps.v["<C-/>"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
end
maps.n["<leader>/"] = false

-- leap
maps.n["<leader>s"] = {
  function()
    local current_window = vim.fn.win_getid()
    require("leap").leap { target_windows = { current_window } }
  end,
  desc = "Bidirectional search",
}
maps.n["<leader>a"] = {
  function()
    local focusable_windows_on_tabpage = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
    require("leap").leap { target_windows = focusable_windows_on_tabpage }
  end,
  desc = "Search in all windows",
}

-- substitute, 交换和替换插件, 寄存器中的值，将会替换到s位置, s{motion}
maps.n["s"] = { require("substitute").operator, desc = "replace with {motion}" }
maps.n["ss"] = { require("substitute").line, desc = "replace with line" }
maps.n["S"] = { require("substitute").eol, desc = "replace until eol" }
maps.v["p"] = { require("substitute").visual, desc = "replace in visual" }
-- exchange
maps.n["sx"] = { require("substitute.exchange").operator, desc = "exchange with {motion}" }
maps.n["sxx"] = { require("substitute.exchange").line, desc = "exchange with line" }
maps.n["sxc"] = { require("substitute.exchange").cancel, desc = "cancel exchange" }
maps.v["X"] = { require("substitute.exchange").visual, desc = "exchange in visual" }

maps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
maps.n["<leader>bD"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(
      function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
    )
  end,
  desc = "Pick to close",
}
-- maps.n["<leader>b"] = { name = "Buffers" }
return maps
