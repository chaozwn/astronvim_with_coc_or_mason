local M = {}
local utils = require "utils"
local system = vim.loop.os_uname().sysname

function M.core_mappings(mappings)
  if not mappings then mappings = require("astrocore").empty_map_table() end
  local maps = mappings
  if maps then
    maps.n["<Leader>n"] = false

    maps.n.n = { utils.better_search "n", desc = "Next search" }
    maps.n.N = { utils.better_search "N", desc = "Previous search" }

    maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
    maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }

    if system == "Darwin" then
      maps.i["<D-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.x["<D-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }
      maps.n["<D-s>"] = { "<Cmd>w<cr>", desc = "Save file", silent = true }

      maps.n["<D-a>"] = {
        function()
          local currentLine = vim.api.nvim_win_get_cursor(0)
          vim.cmd "normal! ggyG"
          vim.api.nvim_win_set_cursor(0, currentLine)
        end,
        desc = "Select all",
      }
    end

    maps.n["n"] = { "nzz" }
    maps.n["N"] = { "Nzz" }

    -- close search highlight
    maps.n["<Leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight", silent = true }

    maps.n["H"] = { "^", desc = "Go to start without blank" }
    maps.n["L"] = { "$", desc = "Go to end without blank" }

    maps.v["<"] = { "<gv", desc = "Unindent line" }
    maps.v[">"] = { ">gv", desc = "Indent line" }
    maps.t["<Esc>"] = { [[<C-\><C-n>]], desc = "Exit terminal mode" }

    -- 在visual mode 里粘贴不要复制
    maps.n["x"] = { '"_x', desc = "Cut without copy" }

    maps.n["<TAB>"] =
      { function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
    maps.n["<S-TAB>"] = {
      function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    }
    maps.n["<Leader>bo"] = maps.n["<Leader>bc"]

    -- lsp restart
    maps.n["<Leader>lm"] = { "<Cmd>LspRestart<CR>", desc = "Lsp restart" }
    maps.n["<Leader>lg"] = { "<Cmd>LspLog<CR>", desc = "Show lsp log" }

    if vim.fn.executable "lazygit" == 1 then
      maps.n["<Leader>tl"] = {
        require("utils").toggle_lazy_git(),
        desc = "ToggleTerm lazygit",
      }
    end

    if vim.fn.executable "lazydocker" == 1 then
      maps.n["<Leader>td"] = {
        require("utils").toggle_lazy_docker(),
        desc = "ToggleTerm lazydocker",
      }
    end

    if vim.fn.executable "btm" == 1 then
      maps.n["<Leader>tt"] = {
        require("utils").toggle_btm(),
        desc = "ToggleTerm btm",
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

  return maps
end

function M.lsp_mappings(mappings)
  if not mappings then mappings = require("astrocore").empty_map_table() end
  local maps = mappings
  if maps then
    -- TODO: remove in astronvim v5
    maps.i["<C-s>"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
      cond = "textDocument/signatureHelp",
    }
    maps.n["<C-s>"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
      cond = "textDocument/signatureHelp",
    }
    maps.n["gK"] = false
    maps.n["gk"] = maps.n["<Leader>lh"]
  end
  return maps
end

return M
