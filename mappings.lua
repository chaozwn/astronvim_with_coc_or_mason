-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
local is_available = utils.is_available
local my_utils = require "user.utils.utils"

local maps = { i = {}, n = {}, v = {}, t = {}, c = {}, o = {}, x = {} }

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

-- telescope plugin mappings
maps.n["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", desc = "File explorer" }
maps.n["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" }
maps.n["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }

-- 上下滚动10行
maps.n["<C-u>"] = { "5k", desc = "Move down 5 lines" }
maps.n["<C-d>"] = { "5j", desc = "Move up 5 lines" }
maps.v["<C-u>"] = { "5k", desc = "Move down 5 lines" }
maps.v["<C-d>"] = { "5j", desc = "Move up 5 lines" }

-- 开启魔术搜索,即可以通过正则来搜索
maps.n["/"] = { "/\\v", desc = "Magic search" }
maps.v["/"] = { "/\\v", desc = "Magic search" }

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
maps.v["<"] = { "<gv", desc = "Indent to the left" }
maps.v[">"] = { ">gv", desc = "Indent to the right" }
maps.v["<Tab>"] = false
maps.v["<S-Tab>"] = false

-- 上下移动选中文本
maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move selected one line down" }
maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move selected one line up" }

-- 在visual mode 里粘贴不要复制
maps.n["x"] = { '"_x', desc = "Cut without copy" }

-- 关闭搜索高亮
maps.n["<leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

-- 分屏快捷键
maps.n["<leader>bw"] = { "<C-w>c", desc = "Close current screen" }
maps.n["<leader>bo"] = { "<C-w>o", desc = "Close other screen" }
-- 多个窗口之间跳转
maps.n["<leader>b="] = { "<C-w>=", desc = "Make all window equal" }

--     -- better search
maps.n["n"] = { my_utils.better_search "n", desc = "Next search" }
maps.n["N"] = { my_utils.better_search "N", desc = "Previous search" }

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
maps.n["<leader><leader>s"] = {
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
maps.n["s"] = { require("substitute").operator, desc = "Replace with {motion}" }
maps.n["ss"] = { require("substitute").line, desc = "Replace with line" }
maps.n["S"] = { require("substitute").eol, desc = "Replace until eol" }
maps.v["p"] = { require("substitute").visual, desc = "Replace in visual" }
-- exchange
maps.n["sx"] = { require("substitute.exchange").operator, desc = "Exchange with {motion}" }
maps.n["sxx"] = { require("substitute.exchange").line, desc = "Exchange with line" }
maps.n["sxc"] = { require("substitute.exchange").cancel, desc = "Exchange exchange" }
maps.v["X"] = { require("substitute.exchange").visual, desc = "Exchange in visual" }

maps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
maps.n["<leader>bD"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(
      function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
    )
  end,
  desc = "Pick to close",
}

-- trouble
maps.n["<leader>x"] = { desc = "裂Trouble" }
maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }

-- better increment/decrement
maps.x["+"] = { "g<C-a>", desc = "Increment number" }
maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

-- buffer switching
maps.n["<Tab>"] = {
  function()
    if #vim.t.bufs > 1 then
      require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
    else
      utils.notify "No other buffers open"
    end
  end,
  desc = "Switch Buffers",
}

-- zen mode
maps.n["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" }

return maps
