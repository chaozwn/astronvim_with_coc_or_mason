local system = vim.loop.os_uname().sysname
local is_available = require("astrocore").is_available
local utils = require "astrocore"
local M = {}

function M.mappings(maps)
  maps.n["<Leader>n"] = false

  maps.n.n = { require("utils").better_search "n", desc = "Next search" }
  maps.n.N = { require("utils").better_search "N", desc = "Previous search" }

  maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
  maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }

  maps.i["<C-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }

  maps.n["<Leader>wo"] = { "<C-w>o", desc = "Close other screen" }
  maps.v["p"] = { "pgvy", desc = "Paste" }
  if vim.fn.executable "btm" == 1 then
    maps.n["<Leader>tT"] = { function() utils.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
  end

  maps.n["n"] = { "nzz" }
  maps.n["N"] = { "Nzz" }
  maps.v["n"] = { "nzz" }
  maps.v["N"] = { "Nzz" }

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

      -- Allow clipboard copy paste in neovim
      vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    end
  end

  -- telescope plugin mappings
  if is_available "telescope.nvim" then
    maps.v["<Leader>f"] = { desc = "󰍉 Find" }
    maps.n["<Leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
    -- buffer switching
    maps.n["<Leader>bt"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
        else
          require("astrocore").notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers In Telescope",
    }
    maps.n["<Leader>fp"] = {
      "<cmd>Telescope projects<CR>",
      desc = "Switch Buffers In Telescope",
    }
  end

  if is_available "nvim-dap-ui" then
    maps.n["<Leader>dj"] = {
      function() require("dap").down() end,
      desc = "Down Strace",
    }
    maps.n["<Leader>dk"] = {
      function() require("dap").up() end,
      desc = "Up Strace",
    }
    maps.n["<Leader>dp"] = {
      function() require("dap.ui.widgets").preview() end,
      desc = "Debugger Preview",
    }
    maps.n["<Leader>dP"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
    maps.n["<Leader>du"] = {
      function() require("dapui").toggle { layout = 2, reset = true } end,
      desc = "Toggle Tray Debugger UI and reset layout",
    }
    maps.n["<Leader>dU"] = {
      function() require("dapui").toggle { reset = true } end,
      desc = "Toggle All Debugger UI and reset layout",
    }
    maps.n["<Leader>dr"] = {
      function() require("dap").run_last() end,
      desc = "Run Last",
    }
    maps.n["<Leader>dR"] = {
      function() require("dap").restart_frame() end,
      desc = "Restart (C-F5)",
    }
    maps.n["<Leader>dd"] = {
      function() require("dapui").float_element() end,
      desc = "Open Dap UI Float Element",
    }
    if is_available "persistent-breakpoints.nvim" then
      maps.n["<F9>"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Debugger: Toggle Breakpoint",
      }
      maps.n["<Leader>db"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Toggle Breakpoint (F9)",
      }
      maps.n["<Leader>dB"] = {
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        desc = "Clear All Breakpoints",
      }
      maps.n["<Leader>dC"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
      maps.n["<F21>"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
    end
  end

  if is_available "noice.nvim" then
    local noice_down = function()
      if not require("noice.lsp").scroll(4) then return "<C-d>" end
    end
    local noice_up = function()
      if not require("noice.lsp").scroll(-4) then return "<C-u>" end
    end

    maps.n["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.i["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.s["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.n["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.i["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.s["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
  end

  if system == "Darwin" or system == "Linux" then
    if is_available "Comment.nvim" then
      maps.n["<C-/>"] = {
        function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Comment line",
      }
      maps.v["<C-/>"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment line",
      }
      maps.n["<Leader>/"] = false
      maps.n["<Leader>/"] = false
    end
  end

  if is_available "dial.nvim" then
    maps.v["<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "visual") end,
      desc = "Increment",
    }
    maps.v["<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "visual") end,
      desc = "Decrement",
    }
    maps.v["g<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "gvisual") end,
      desc = "Increment",
    }
    maps.v["g<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "gvisual") end,
      desc = "Decrement",
    }
    maps.n["<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "normal") end,
      desc = "Increment",
    }
    maps.n["<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "normal") end,
      desc = "Decrement",
    }
    maps.n["g<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "gnormal") end,
      desc = "Increment",
    }
    maps.n["g<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "gnormal") end,
      desc = "Decrement",
    }
  end

  if is_available "marks.nvim" then
    -- print(require("astrocore").is_available "marks.nvim")
    -- marks
    maps.n["m"] = { desc = "󰈚 Marks" }
    maps.n["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" }
    maps.n["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" }
    maps.n["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" }
    maps.n["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" }
    maps.n["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" }

    maps.n["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" }
    maps.n["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" }
    maps.n["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" }
  end

  -- close search highlight
  maps.n["<Leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

  maps.n["<Leader><Leader>"] = { desc = "󰍉 User" }

  maps.n["H"] = { "^", desc = "Go to start without blank" }
  maps.n["L"] = { "$", desc = "Go to end without blank" }

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

  maps.v["<"] = { "<gv", desc = "Unindent line" }
  maps.v[">"] = { ">gv", desc = "Indent line" }

  if is_available "toggleterm.nvim" then
    if vim.fn.executable "lazygit" == 1 then
      maps.n["<Leader>tl"] = {
        require("utils").toggle_lazy_git(),
        desc = "ToggleTerm lazygit",
      }
      maps.n["<Leader>gg"] = maps.n["<Leader>tl"]
    end

    if vim.fn.executable "yazi" == 1 then
      maps.n["<Leader>ty"] = {
        require("utils").toggle_yazi(),
        desc = "ToggleTerm yazi",
      }
    end

    if vim.fn.executable "unimatrix" == 1 then
      maps.n["<Leader>tm"] = {
        require("utils").toggle_unicmatrix(),
        desc = "ToggleTerm unimatrix",
      }
    end

    if vim.fn.executable "lazydocker" == 1 then
      maps.n["<Leader>td"] = {
        require("utils").toggle_lazy_docker(),
        desc = "ToggleTerm lazydocker",
      }
    end
  end

  -- 在visual mode 里粘贴不要复制
  maps.n["x"] = { '"_x', desc = "Cut without copy" }

  -- 分屏快捷键
  maps.n["<Leader>w"] = { desc = "󱂬 Window" }
  maps.n["<Leader>ww"] = { "<cmd><cr>", desc = "Save" }
  maps.n["<Leader>wc"] = { "<C-w>c", desc = "Close current screen" }
  maps.n["<Leader>wo"] = { "<C-w>o", desc = "Close other screen" }
  -- 多个窗口之间跳转
  maps.n["<Leader>we"] = { "<C-w>=", desc = "Make all window equal" }
  maps.n["<TAB>"] =
    { function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
  maps.n["<S-TAB>"] = {
    function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Previous buffer",
  }
  maps.n["<Leader>bo"] =
    { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
  maps.n["<Leader>ba"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
  maps.n["<Leader>bc"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
  maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
  maps.n["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
  maps.n["<Leader>bD"] = {
    function()
      require("astrocore.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
    end,
    desc = "Pick to close",
  }

  -- lsp restart
  maps.n["<Leader>lm"] = { "<Cmd>LspRestart<CR>", desc = "Lsp restart" }
  maps.n["<Leader>lg"] = { "<Cmd>LspLog<CR>", desc = "Show lsp log" }

  if is_available "nvim-treesitter" then
    -- TsInformation
    maps.n["<Leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }
  end

  return maps
end

return M
