local utils = require "utils"
local system = vim.loop.os_uname().sysname

return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
    local maps = opts.mappings
    if maps then
      maps.n["<Leader>n"] = false

      maps.n.n = { require("utils").better_search "n", desc = "Next search" }
      maps.n.N = { require("utils").better_search "N", desc = "Previous search" }

      maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
      maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }

      maps.i["<C-S>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.x["<C-S>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.n["<C-S>"] = { "<Cmd>w<cr>", desc = "Save file", silent = true }

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

      -- close search highlight
      maps.n["<Leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight", silent = true }

      maps.n["H"] = { "^", desc = "Go to start without blank" }
      maps.n["L"] = { "$", desc = "Go to end without blank" }

      maps.v["<"] = { "<gv", desc = "Unindent line" }
      maps.v[">"] = { ">gv", desc = "Indent line" }

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

      -- lsp restart
      maps.n["<Leader>lm"] = { "<Cmd>LspRestart<CR>", desc = "Lsp restart" }
      maps.n["<Leader>lg"] = { "<Cmd>LspLog<CR>", desc = "Show lsp log" }

      if vim.fn.executable "lazygit" == 1 then
        maps.n["<Leader>tl"] = {
          require("utils").toggle_lazy_git(),
          desc = "ToggleTerm lazygit",
        }
        maps.n["<Leader>gg"] = maps.n["<Leader>tl"]
      end

      if vim.fn.executable "lazydocker" == 1 then
        maps.n["<Leader>td"] = {
          require("utils").toggle_lazy_docker(),
          desc = "ToggleTerm lazydocker",
        }
      end

      if vim.fn.executable "unimatrix" == 1 then
        maps.n["<Leader>tm"] = {
          require("utils").toggle_unicmatrix(),
          desc = "ToggleTerm unimatrix",
        }
      end

      if vim.fn.executable "tte" == 1 then
        maps.n["<Leader>te"] = {
          require("utils").toggle_tte(),
          desc = "ToggleTerm tte",
        }
      end
    end

    opts.mappings = maps
  end,
}
