-- o is operator pending mode
-- x is visual mode
local M = {}

function M.mappings(maps)
  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  local utils = require "astronvim.utils"
  local is_available = utils.is_available
  local my_utils = require "user.utils.utils"

  -- print(require("astronvim.utils").is_available "flash.nvim")
  -- print(vim.fn.has "unix" == 1)
  local system = vim.loop.os_uname().sysname

  maps.x = {}
  maps.o = {}

  -- better search
  maps.n["n"] = { my_utils.better_search "n", desc = "Next search" }
  maps.n["N"] = { my_utils.better_search "N", desc = "Previous search" }

  maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
  maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }

  if is_available "nvim-dap-ui" then
    maps.n["<leader>dU"] = {
      function() require("dapui").toggle { reset = true } end,
      desc = "Toggle Debugger UI and reset layout",
    }
    if is_available "persistent-breakpoints.nvim" then
      maps.n["<F9>"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Debugger: Toggle Breakpoint",
      }
      maps.n["<leader>db"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Toggle Breakpoint (F9)",
      }
      maps.n["<leader>dB"] = {
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        desc = "Clear All Breakpoints",
      }
      maps.n["<leader>dC"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
      maps.n["<F21>"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
    end
  end

  if is_available "neotest" then
    local neotest = require "neotest"
    maps.n["<leader>m"] = { desc = "󰇉 Test" }
    maps.n["<leader>mc"] = { function() neotest.run.run() end, desc = "Run nearest" }
    maps.n["<leader>mC"] = { function() neotest.run.run { strategy = "dap" } end, desc = "Run nearest with dap" }
    maps.n["<leader>mt"] = { function() neotest.run.run(vim.fn.expand "%") end, desc = "Run file" }
    maps.n["<leader>mT"] =
      { function() neotest.run.run { vim.fn.expand "%", strategy = "dap" } end, desc = "Run file with dap" }
    maps.n["<leader>ma"] = { function() neotest.run.run(vim.loop.cwd()) end, desc = "Run all test files" }
    maps.n["<leader>ms"] = { function() neotest.summary.toggle() end, desc = "Toggle summary" }
    maps.n["<leader>mo"] =
      { function() neotest.output.open { enter = true, auto_close = true } end, desc = "Show output" }
    maps.n["<leader>mO"] = { function() neotest.output_panel.toggle() end, desc = "Toggle output panel" }
    maps.n["<leader>mS"] = { function() neotest.run.stop() end, desc = "Stop test" }
  end

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

  if is_available "markdown-preview.nvim" then
    maps.n["<leader>ue"] = { "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown preview" }
  end

  if is_available "vim-jukit" then
    maps.n["<leader>j"] = { desc = " Jupyter" }
    maps.v["<leader>j"] = { desc = " Jupyter" }

    -- Open
    maps.n["<leader>jo"] = { desc = "Open" }
    maps.n["<leader>joo"] = {
      "<cmd>call jukit#splits#output()<CR>",
      desc = "Open ipython window",
    }
    maps.n["<leader>jot"] = { "<cmd>call jukit#splits#term()<CR>", desc = "Open terminal window" }
    maps.n["<leader>joh"] = { "<cmd>call jukit#splits#history()<CR>", desc = "Open history window" }
    maps.n["<leader>joa"] =
      { "<cmd>call jukit#splits#output_and_history()<CR>", desc = "Open terminal and history window" }

    -- Close
    maps.n["<leader>jc"] = { desc = "Close" }
    maps.n["<leader>jch"] = { "<cmd>call jukit#splits#close_history()<CR>", desc = "Close output history window" }
    maps.n["<leader>jco"] = { "<cmd>call jukit#splits#close_output_split()<CR>", desc = "Close output window" }
    -- Argument: Whether or not to ask you to confirm before closing
    maps.n["<leader>jca"] = { "<cmd>call jukit#splits#close_output_and_history(1)<CR>", desc = "Close both windows" }

    -- Show
    maps.n["<leader>jS"] = { desc = "Show" }
    maps.n["<leader>jSc"] =
      { "<cmd>call jukit#splits#show_last_cell_output(1)<CR>", desc = "Show last cell output in output history window" }

    -- Scroll
    maps.n["<leader>js"] = { desc = "Scroll" }
    maps.n["<leader>jsj"] = { "<cmd>call jukit#splits#out_hist_scroll(1)<CR>", desc = "Scroll down in history window" }
    maps.n["<leader>jsk"] = { "<cmd>call jukit#splits#out_hist_scroll(0)<CR>", desc = "Scroll up in history window" }

    -- UI autocmd
    maps.n["<leader>ju"] = { desc = "UI" }
    maps.n["<leader>juh"] =
      { "<cmd>call jukit#splits#toggle_auto_hist()", desc = "Toggle auto displaying saved output on CursorHold" }
    maps.n["<leader>jul"] = { "<cmd>call jukit#layouts#set_layout()<CR>", desc = "Apply layout to current splits" }
    maps.n["<leader>jup"] =
      { "<cmd>call jukit#ueberzug#set_default_pos()<CR>", desc = "Set position and dimension of ueberzug window" }

    -- Execute
    maps.n["<leader>je"] = { desc = "Execute" }
    maps.v["<leader>je"] = { desc = "Execute" }
    maps.n["<leader>jer"] = { "<cmd>call jukit#send#section(0)<CR>", desc = "Execute current cell" }
    maps.n["<leader>jel"] = { "<cmd>call jukit#send#line()<CR>", desc = "Execute current line" }
    maps.v["<leader>jer"] = { "<cmd>call jukit#send#selection()<CR>", desc = "Execute selected code" }
    maps.n["<leader>jeu"] =
      { "<cmd>call jukit#send#until_current_section()<CR>", desc = "Execute all cells until current cell" }
    maps.n["<leader>jea"] = { "<cmd>call jukit#send#all()<CR>", desc = "Execute all cells" }

    -- Cell
    maps.n["<leader>jj"] = { desc = "Cell" }
    maps.n["<leader>jjo"] = { "<cmd>call jukit#cells#create_below(0)<CR>", desc = "Create code cell below" }
    maps.n["<leader>jjO"] = { "<cmd>call jukit#cells#create_above(0)<CR>", desc = "Create code cell above" }
    maps.n["<leader>jjt"] = { "<cmd>call jukit#cells#create_below(1)<CR>", desc = "Create markdown cell below" }
    maps.n["<leader>jjT"] = { "<cmd>call jukit#cells#create_above(1)<CR>", desc = "Create markdown cell above" }
    maps.n["<leader>jjd"] = { "<cmd>call jukit#cells#delete()<CR>", desc = "Delete current cell" }
    maps.n["<leader>jjs"] = { "<cmd>call jukit#cells#split()<CR>", desc = "Split current cell" }
    maps.n["<leader>jjm"] =
      { "<cmd>call jukit#cells#merge_below()<CR>", desc = "Merge current cell with the cell below" }
    maps.n["<leader>jjM"] =
      { "<cmd>call jukit#cells#merge_above()<CR>", desc = "Merge current cell with the cell above" }
    maps.n["<leader>jjK"] = { "<cmd>call jukit#cells#move_up()<CR>", desc = "Move current cell up" }
    maps.n["<leader>jjJ"] = { "<cmd>call jukit#cells#move_down()<CR>", desc = "Move current cell down" }
    maps.n["<leader>jjj"] = { "<cmd>call jukit#cells#jump_to_next_cell()<CR>", desc = "Jump to next cell below" }
    maps.n["<leader>jjk"] =
      { "<cmd>call jukit#cells#jump_to_previous_cell()<CR>", desc = "Jump to previous cell above" }
    maps.n["<leader>jjc"] = { "<cmd>call jukit#cells#delete_outputs(0)<CR>", desc = "Clear current cell output" }
    maps.n["<leader>jja"] = { "<cmd>call jukit#cells#delete_outputs(1)<CR>", desc = "Clear all cell output" }

    -- Conversion
    maps.n["<leader>jm"] = { desc = "Conversion" }
    maps.n["<leader>jmj"] =
      { "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<CR>", desc = "Convert py to jupyter notebook" }
    if vim.g.jukit_html_viewer then
      maps.n["<leader>jmt"] =
        { "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<CR>", desc = "Convert file to html" }
      maps.n["<leader>jmT"] =
        { "<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<CR>", desc = "Convert file to html with rerun all code" }
    end

    if vim.g.jukit_pdf_viewer then
      maps.n["<leader>jmp"] = { "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<CR>", desc = "Convert file to pdf" }
      maps.n["<leader>jmP"] =
        { "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<CR>", desc = "Convert file to pdf with rerun all code" }
    end

    -- Env
    maps.n["<leader>jn"] = { desc = "Env" }
    maps.n["<leader>jnc"] = { ":JukitOut conda activate ", desc = "Activate conda env" }
    maps.n["<leader>jnC"] = { ":JukitOutHist conda activate ", desc = "Activate conda env with history window" }
  end

  if is_available "marks.nvim" then
    -- marks
    maps.n["m"] = { desc = "Marks" }
    maps.n["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" }
    maps.n["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" }
    maps.n["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" }
    maps.n["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" }
    maps.n["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" }

    maps.n["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" }
    maps.n["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" }
    maps.n["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" }
  end

  -- 关闭搜索高亮
  maps.n["<leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

  -- chatgpt
  if is_available "neoai.nvim" then
    maps.n["<leader>n"] = { desc = "󰚩 Chatgpt" }
    maps.v["<leader>n"] = { desc = "󰚩 Chatgpt" }
    -- NOTE: note that the plugin has a feature where the output from the model automatically gets saved to the g register and all code snippets get saved to the c register. These can be changed in the config.
    maps.n["<leader>no"] = { "<cmd>NeoAI<CR>", desc = "Toggle NeoAI" }
    maps.n["<leader>ne"] = { "<cmd>NeoAIToggle<CR>", desc = "Toggle NeoAI" }
    maps.n["<leader>na"] = { "<cmd>NeoAIContext<CR>", desc = "Choose all code" }
    maps.v["<leader>nf"] = { ":NeoAIContext<CR>", desc = "Select code" }
    maps.n["<leader>ni"] = { ":NeoAIInject ", desc = "Inject code with prompt" }
  end

  maps.n["<leader><leader>"] = { desc = "󰍉 User" }
  -- maps.n["<leader>m"] = { desc = "󱂬 Translate" }
  maps.n["s"] = "<Nop>"

  -- terminal
  if "toggleterm.nvim" then maps.t["<C-[>"] = { [[<C-\><C-n>]], desc = "Exit Terminal Mode" } end

  -- close mason
  if is_available "refactoring.nvim" then
    maps.n["<leader>r"] = { desc = " Refactor" }
    maps.v["<leader>r"] = { desc = " Refactor" }
  end

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
  if is_available "auto-save.nvim" then maps.n["<leader>um"] = { ":ASToggle<CR>", desc = "Toggle AutoSave" } end

  if is_available "vim-visual-multi" then
    -- visual multi
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Up"] = "<C-S-k>",
      ["Add Cursor Down"] = "<C-S-j>",
      ["Select All"] = "<C-S-n>",
      ["Skip Region"] = "<C-x>",
    }
  end

  -- telescope plugin mappings
  if is_available "telescope.nvim" then
    maps.v["<leader>f"] = { desc = "󰍉 Find" }
    maps.n["<leader>fp"] =
      { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" }
    maps.n["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
    maps.n["<leader>fM"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
    maps.n["<leader>fm"] = { "<cmd>Telescope media_files<cr>", desc = "Find media files" }
    maps.n["<leader>fN"] = { "<cmd>Telescope noice<cr>", desc = "Find noice" }
    maps.v["<leader>fr"] =
      { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "Find code refactors" }
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
  end

  -- visual模式下缩进代码, 缩进后仍然可以继续选中区域
  maps.v["<"] = { "<gv", desc = "Indent to the left" }
  maps.v[">"] = { ">gv", desc = "Indent to the right" }

  -- 在visual mode 里粘贴不要复制
  maps.n["x"] = { '"_x', desc = "Cut without copy" }

  -- 分屏快捷键
  maps.n["<leader>w"] = { desc = "󱂬 Window" }
  maps.n["<leader>ww"] = { "<cmd><cr>", desc = "Save" }
  maps.n["<leader>wc"] = { "<C-w>c", desc = "Close current screen" }
  maps.n["<leader>wo"] = { "<C-w>o", desc = "Close other screen" }
  -- 多个窗口之间跳转
  maps.n["<leader>w="] = { "<C-w>=", desc = "Make all window equal" }
  maps.n["<TAB>"] =
    { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
  maps.n["<S-TAB>"] = {
    function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Previous buffer",
  }
  maps.n["<leader>bo"] =
    { function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
  maps.n["<leader>ba"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
  maps.n["<leader>bc"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
  maps.n["<leader>bC"] =
    { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }
  maps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
  maps.n["<leader>bD"] = {
    function()
      require("astronvim.utils.status").heirline.buffer_picker(
        function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
      )
    end,
    desc = "Pick to close",
  }

  -- lsp restart
  maps.n["<leader>lm"] = { ":LspRestart<CR>", desc = "Lsp restart" }
  maps.n["<leader>lg"] = { ":LspLog<CR>", desc = "Show lsp log" }

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

  if is_available "flash.nvim" then
    maps.n["<leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.x["<leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.o["<leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.n["<leader><leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
    maps.x["<leader><leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
    maps.o["<leader><leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
  end

  if is_available "substitute.nvim" then
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
  end

  -- trouble
  if is_available "trouble.nvim" then
    maps.n["<leader>x"] = { desc = " Trouble" }
    maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
    maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
    maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
    maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
    maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }
  end

  maps.n["<leader>z"] = { desc = " Tools" }
  if is_available "ccc.nvim" then
    maps.n["<leader>zp"] = { "<CMD>CccPick<CR>", desc = "Pick color" }
    maps.n["<leader>zc"] = { "<CMD>CccConvert<CR>", desc = "Convert color" }
    maps.n["<leader>uC"] = { "<CMD>CccHighlighterToggle<CR>", desc = "Toggle ccc highlighter" }
  end

  if is_available "zen-mode.nvim" then
    -- zen mode
    maps.n["<leader>zz"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" }
  end

  if is_available "nvim-treesitter" then
    -- TsInformation
    maps.n["<leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }
  end

  if is_available "neoconf.nvim" then
    -- maps.n["<leader>n"] = { desc = " Neoconf" }
    maps.n["<leader>pd"] = { "<cmd>Neoconf<CR>", desc = "Select local/global neoconf config" }
    maps.n["<leader>pb"] = { "<cmd>Neoconf show<CR>", desc = "Show neoconf merge config" }
    maps.n["<leader>pc"] = { "<cmd>Neoconf lsp<CR>", desc = "Show neoconf merge lsp config" }
  end

  return maps
end

return M
