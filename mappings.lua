-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
local is_available = utils.is_available
local my_utils = require "user.utils.utils"
local lsp_type = require("user.config.lsp_type").lsp_type

local maps = { i = {}, n = {}, v = {}, t = {}, c = {}, o = {}, x = {} }

local system = vim.loop.os_uname().sysname

if vim.g.neovide then
  if system == "Darwin" then
    vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
    -- Save
    maps.n["<D-s>"] = ":w<CR>"
    -- Paste normal mode
    maps.n["<D-v>"] = '"+P'
    -- Copy
    maps.v["<D-c>"] = '"+y'
    -- Paste visual mode
    maps.v["<D-v>"] = '"+P'
    -- Paste command mode
    maps.c["<D-v>"] = "<C-R>+"
    -- Paste insert mode
    maps.i["<D-v>"] = '<esc>"+pli'
  elseif system == "window" then
  end
end

-- lsp inlayhints
maps.n["<leader>uh"] = {
  function() require("lsp-inlayhints").toggle() end,
  desc = "Toggle lspInlayHints",
}

maps.n["<leader><leader>"] = { desc = "󰍉 User" }
-- maps.n["<leader>m"] = { desc = "󱂬 Translate" }
maps.n["s"] = "<Nop>"

-- close mason
if lsp_type == "coc" then maps.n["<leader>pa"] = false end

if lsp_type ~= "coc" then
  maps.n["<leader>r"] = { desc = " Refactor" }
  maps.v["<leader>r"] = { desc = " Refactor" }
  -- refactoring
  -- Remaps for the refactoring operations currently offered by the plugin
  maps.v["<leader>rf"] = {
    "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
    desc = "Extract Function",
  }
  maps.v["<leader>rF"] = {
    "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
    desc = "Extract Function To File",
  }
  maps.v["<leader>rv"] = {
    "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
    desc = "Extract Variable",
  }
  maps.v["<leader>ri"] =
  { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "Inline Variable" }

  -- Extract block doesn't need visual mode
  maps.n["<leader>rb"] = {
    "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
    desc = "Extract Block",
  }
  maps.n["<leader>rB"] = {
    "<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
    desc = "Extract Block To File",
  }
  -- Inline variable can also pick up the identifier currently under the cursor without visual mode
  maps.n["<leader>ri"] = {
    "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
    desc = "Inline Variable",
  }
end

-- Debug
-- maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }
-- maps.n["<leader>dC"] =
-- { function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint" }
--
-- if is_available "nvim-dap-ui" then
--   maps.n["<leader>dE"] =
-- ---@diagnostic disable-next-line: missing-parameter
--   { function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input" }
-- ---@diagnostic disable-next-line: missing-parameter
--   maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
-- end
-- maps.n["<leader>ds"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor" }
-- maps.n["<leader>dE"] = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", desc = "Evaluate Input" }
-- maps.n["<leader>dC"] =
--   { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint" }

-- tmux
maps.n["<C-h>"] = { "<cmd>lua require'tmux'.move_left()<cr>", desc = "Go to left window" }
maps.n["<C-l>"] = { "<cmd>lua require'tmux'.move_right()<cr>", desc = "Go to right window" }
maps.n["<C-j>"] = { "<cmd>lua require'tmux'.move_bottom()<cr>", desc = "Go to bottom window" }
maps.n["<C-k>"] = { "<cmd>lua require'tmux'.move_top()<cr>", desc = "Go to top window" }

maps.n["<C-Up>"] = { "<cmd>lua require'tmux'.resize_top()<cr>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>lua require'tmux'.resize_bottom()<cr>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>lua require'tmux'.resize_left()<cr>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>lua require'tmux'.resize_right()<cr>", desc = "Resize split right" }

maps.n["m"] = { desc = "Marks" }
maps.n["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" }
maps.n["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" }
maps.n["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" }
maps.n["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" }
maps.n["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" }

maps.n["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" }
maps.n["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" }
maps.n["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" }

maps.n["H"] = { "^", desc = "Go to start without blank" }
maps.n["L"] = { "$", desc = "Go to end without blank" }

-- $跳到行尾不带空格(交换$和g_)
maps.n["$"] = { "g_", desc = "Go to end without blank" }
maps.n["g_"] = { "$", desc = "Go to end" }
maps.v["$"] = { "g_", desc = "Go to end without blank" }
maps.v["g_"] = { "$", desc = "Go to end" }
maps.n["0"] = { "^", desc = "Go to start without blank" }
maps.n["^"] = { "0", desc = "Go to start" }
maps.v["0"] = { "^", desc = "Go to start without blank" }
maps.v["^"] = { "0", desc = "Go to start" }

-- auto save开关
maps.n["<leader>um"] = { ":ASToggle<CR>", desc = "Toggle AutoSave" }

-- visual multi
vim.g.VM_maps = {
  ["Find Under"] = "<C-n>",
  ["Find Subword Under"] = "<C-n>",
  ["Add Cursor Up"] = "<C-S-k>",
  ["Add Cursor Down"] = "<C-S-j>",
  ["Select All"] = "<C-S-n>",
  ["Skip Region"] = "<C-x>",
}

-- telescope plugin mappings
maps.v["<leader>f"] = { desc = "󰍉 Find" }
maps.n["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" }
maps.n["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
maps.n["<leader>fM"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
maps.n["<leader>fm"] = { "<cmd>Telescope media_files<cr>", desc = "Find media files" }
maps.v["<leader>fr"] =
{ "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "Find code refactors" }
-- maps.n["<leader>fR"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }

-- 上下滚动10行
-- maps.n["<C-u>"] = { "5k", desc = "Move down 5 lines" }
-- maps.n["<C-d>"] = { "5j", desc = "Move up 5 lines" }
-- maps.v["<C-u>"] = { "5k", desc = "Move down 5 lines" }
-- maps.v["<C-d>"] = { "5j", desc = "Move up 5 lines" }

-- 开启魔术搜索,即可以通过正则来搜索
-- maps.n["/"] = { "/\\v", desc = "Magic search" }
-- maps.v["/"] = { "/\\v", desc = "Magic search" }

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
maps.v["<"] = { "<gv", desc = "Indent to the left" }
maps.v[">"] = { ">gv", desc = "Indent to the right" }
maps.v["<Tab>"] = false
maps.v["<S-Tab>"] = false

-- 上下移动选中文本
-- maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move selected one line down" }
-- maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move selected one line up" }

-- 在visual mode 里粘贴不要复制
maps.n["x"] = { '"_x', desc = "Cut without copy" }

-- 关闭搜索高亮
maps.n["<leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

-- 分屏快捷键
maps.n["<leader>w"] = { desc = "󱂬 Window" }
maps.n["<leader>wc"] = { "<C-w>c", desc = "Close current screen" }
maps.n["<leader>wo"] = { "<C-w>o", desc = "Close other screen" }
-- 多个窗口之间跳转
maps.n["<leader>w="] = { "<C-w>=", desc = "Make all window equal" }

maps.n["<leader>bo"] =
{ function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
maps.n["<leader>ba"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
maps.n["<leader>bc"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
maps.n["<leader>bC"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }

-- better search
maps.n["n"] = { my_utils.better_search "n", desc = "Next search" }
maps.n["N"] = { my_utils.better_search "N", desc = "Previous search" }

-- lsp restart
if lsp_type ~= "coc" then
  maps.n["<leader>lm"] = { ":LspRestart<CR>", desc = "Lsp restart" }
  maps.n["<leader>lg"] = { ":LspLog<CR>", desc = "Show lsp log" }
end

-- Comment
if is_available "Comment.nvim" then
  maps.n["<C-/>"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
  }
  maps.v["<C-/>"] =
  { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
end
maps.v["<leader>/"] = false
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
if lsp_type ~= "coc" then
  maps.n["<leader>x"] = { desc = "裂Trouble" }
  maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
  maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
  maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
  maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
  maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }
end

-- better increment/decrement
-- maps.x["+"] = { "g<C-a>", desc = "Increment number" }
-- maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

-- buffer switching
maps.n["<leader>bt"] = {
  function()
    if #vim.t.bufs > 1 then
      require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
    else
      utils.notify "No other buffers open"
    end
  end,
  desc = "Switch Buffers In Telescope",
}

-- zen mode
maps.n["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" }

-- TsInformation
maps.n["<leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }

-- coc lsp keymapping
if lsp_type == "coc" then
  maps.n["<leader>ue"] = {
    "get(g:, 'coc_enabled', 0) == 1 ? ':CocDisable<cr>' : ':CocEnable<cr>'",
    desc = "Toggle Coc",
    expr = true,
  }
  maps.n["<leader>ui"] = { ":CocCommand document.toggleInlayHint<CR>", desc = "Toggle Inlayhints" }

  -- Autocomplete
  function _G.check_back_space()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
  end

  maps.i["<TAB>"] = {
    'coc#pum#visible() ? coc#pum#confirm() :  "\\<TAB>"',
    expr = true,
    silent = true,
    replace_keycodes = false,
    nowait = true,
  }
  -- maps.i["<S-TAB>"] = {
  --   [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
  --   expr = true,
  --   silent = true,
  --   replace_keycodes = false,
  --   nowait = true
  -- }

  maps.i["<C-j>"] = {
    'coc#pum#visible() ? coc#pum#next(1) : "\\<C-j>"',
    expr = true,
    replace_keycodes = false,
    silent = true,
    nowait = true,
  }
  maps.i["<C-k>"] = {
    'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-k>"',
    expr = true,
    replace_keycodes = false,
    silent = true,
    nowait = true,
  }
  maps.i["<CR>"] = {
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    expr = true,
    replace_keycodes = false,
    silent = true,
    nowait = true,
  }

  -- maps.i["<C-j>"] = { "<Plug>(coc-snippets-expand-jump)" }
  maps.n["[d"] = { "<Plug>(coc-diagnostic-prev)", desc = "Previous diagnostic" }
  maps.n["]d"] = { "<Plug>(coc-diagnostic-next)", desc = "Next diagnostic" }
  maps.n["gD"] = { "<cmd>Telescope coc declarations<CR>", desc = "Declaration of current symbol" }
  maps.n["gd"] = { "<cmd>Telescope coc definitions<CR>", desc = "Show the definition of current symbol" }
  maps.n["gT"] = { "<cmd>Telescope coc type_definitions<CR>", desc = "Definition of current type" }
  maps.n["gI"] = { "<cmd>Telescope coc implementations<CR>", desc = "Implementation of current symbol" }
  maps.n["gr"] = { "<cmd>Telescope coc references<CR>", desc = "References of current symbol" }
  -- Use K to show documentation in preview window
  function _G.show_docs()
    local cw = vim.fn.expand "<cword>"
    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
      vim.api.nvim_command("h " .. cw)
    elseif vim.api.nvim_eval "coc#rpc#ready()" then
      vim.fn.CocActionAsync "doHover"
    else
      vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
  end

  maps.n["K"] = { "<CMD>lua _G.show_docs()<CR>", desc = "Hover symbol details" }
  maps.n["<leader>lr"] = { "<Plug>(coc-rename)", desc = "Rename current symbol" }
  maps.n["<leader>lf"] = { "<CMD>Format<CR>", desc = "Format buffer" }
  maps.x["<leader>lf"] = { "<cmd>call CocActionAsync('format')<CR>", desc = "Format buffer" }
  -- TODO: 解决coc-tsserver tsserver.reloadProjects导致后续请求cancel的问题
  maps.n["<leader>la"] = { "<Plug>(coc-codeaction)", desc = "LSP code action" }
  maps.n["<leader>lA"] = { "<Plug>(coc-codeaction-source)", desc = "Code action whole buffer" }
  maps.n["<leader>lL"] = { "<Plug>(coc-codelens-action)", desc = "LSP CodeLens run" }
  -- maps.n["<leader>li"] = { "<Plug>(coc-fix-current)", desc = "LSP fix current" }
  -- TODO: 增加手动signture提示
  -- maps.n["<leader>lh"] = { "<cmd>call CocAction('showSignatureHelp')<CR>", desc = "Signature help" }
  maps.n["<leader>r"] = { desc = " Refactor" }
  maps.v["<leader>r"] = { desc = " Refactor" }
  maps.n["<leader>re"] = { "<Plug>(coc-codeaction-refactor)", desc = "Code refactor" }
  maps.x["<leader>rs"] = { "<Plug>coc-codeaction-refactor-selected)", desc = "Code refactor selected" }
  maps.n["<leader>rs"] = { "<Plug>coc-codeaction-refactor-selected)", desc = "Code refactor selected" }

  -- text object
  maps.x["if"] = { "<Plug>(coc-funcobj-i)" }
  maps.o["if"] = { "<Plug>(coc-funcobj-i)" }
  maps.x["af"] = { "<Plug>(coc-funcobj-a)" }
  maps.o["af"] = { "<Plug>(coc-funcobj-a)" }
  maps.x["ic"] = { "<Plug>(coc-classobj-i)" }
  maps.o["ic"] = { "<Plug>(coc-classobj-i)" }
  maps.x["ac"] = { "<Plug>(coc-classobj-a)" }
  maps.o["ac"] = { "<Plug>(coc-classobj-a)" }

  maps.n["<C-u>"] =
  { 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-u>"', expr = true, silent = true, nowait = true }
  maps.n["<C-d>"] =
  { 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-d>"', expr = true, silent = true, nowait = true }
  maps.i["<C-u>"] = {
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<C-u>"',
    expr = true,
    silent = true,
    nowait = true,
  }
  maps.i["<C-d>"] = {
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<C-d>"',
    expr = true,
    silent = true,
    nowait = true,
  }
  maps.v["<C-u>"] =
  { 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-u>"', expr = true, silent = true, nowait = true }
  maps.v["<C-d>"] =
  { 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-d>"', expr = true, silent = true, nowait = true }

  -- maps.n["<leader>li"] = { ":<C-u>CocList --normal gstatus<CR>", desc = "LSP status" }
  maps.n["<leader>lS"] = { "<cmd>CocOutline<CR>", desc = "Symbols outline" }
  maps.n["<leader>ls"] = { "<cmd>Telescope coc document_symbols<CR>", desc = "Search symbols" }
  maps.n["<leader>lD"] = { "<cmd>Telescope coc diagnostics<CR>", desc = "Show current file diagnostics" }
  maps.n["<leader>lW"] = { "<cmd>Telescope coc workspace_diagnostics<cr>", desc = "Show workspace diagnostics" }
  maps.n["<leader>lG"] = { "<cmd>Telescope coc workspace_symbols<CR>", desc = "Search workspace symbols" }
  maps.n["<leader>pe"] = { ":<C-u>CocList extensions<cr>", desc = "Manage extensions" }
  maps.n["<leader>pc"] = { "<cmd>Telescope coc commands<CR>", desc = "Show coc commands" }
  maps.n["<leader>lm"] = { "<cmd>CocRestart<cr>", desc = "Coc restart" }
  -- maps.n["<leader>pR"] = { ":<C-u>CocListResume<cr>", desc = "Resume latest coc list" }
  -- maps.n["<C-k>"] = { ":<C-u>CocPrev<cr>", desc = "Coc previous" }
  -- maps.n["<C-j>"] = { ":<C-u>CocNext<cr>", desc = "Coc next" }

  maps.n["mm"] = { "<Plug>(coc-translator-p)", desc = "Translate word" }
  maps.v["mm"] = { "<Plug>(coc-translator-pv)", desc = "Translate word" }
end

return maps
