local function get_filename_from_path(path) return path:match "([^/\\]+)$" end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        maps.n["<Leader>xs"] = {
          "<cmd>JupyniumStartAndAttachToServer<CR>",
          desc = "Jupynium start and attach to server",
        }

        maps.n["<Leader>xd"] = {
          function()
            local file = get_filename_from_path(vim.api.nvim_buf_get_name(0)):match "([^%.]+)"

            vim.ui.input({ prompt = "File Name: ", default = file .. ".ipynb" }, function(input)
              if not input or #input == 0 then return end
              local execute_command = ([[:JupyniumStartSync ]] .. input)
              vim.cmd(execute_command)
            end)
          end,
          desc = "Jupynium start sync",
        }

        maps.n["<Leader>xr"] = {
          "<cmd>JupyniumExecuteSelectedCells<CR>",
          desc = "Jupynium execute selected cells",
        }
        maps.x["<Leader>xr"] = maps.n["<Leader>xr"]

        maps.n["<Leader>xc"] = {
          "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
          desc = "Jupynium clear selected cells",
        }
        maps.x["<Leader>xc"] = maps.n["<Leader>xc"]

        maps.n["<Leader>xh"] = {
          "<cmd>JupyniumKernelHover<cr>",
          desc = "Jupynium hover (inspect a variable)",
        }

        maps.n["<Leader>xx"] = {
          "<cmd>JupyniumScrollToCell<cr>",
          desc = "Jupynium scroll to cell",
        }
        maps.x["<Leader>xx"] = maps.n["<Leader>xx"]

        maps.n["<Leader>xt"] = {
          "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
          desc = "Jupynium toggle selected cell output scroll",
        }
        maps.x["<Leader>xt"] = maps.n["<Leader>xt"]

        vim.keymap.set("", "<Leader>xk", "<cmd>JupyniumScrollUp<cr>", { desc = "Jupynium scroll up" })

        vim.keymap.set("", "<Leader>xj", "<cmd>JupyniumScrollDown<cr>", { desc = "Jupynium scroll down" })
      end
      opts.mappings = maps
    end,
  },
  {
    "kiyoon/jupynium.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
      "stevearc/dressing.nvim",
    },
    opts = {
      python_host = "python",
      default_notebook_URL = "localhost:8888/nbclassic",
      jupyter_command = "jupyter",
      use_default_keybindings = false,
      auto_download_ipynb = false,
    },
    build = "pip install --user .",
  },
}
