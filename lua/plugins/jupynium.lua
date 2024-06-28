local prefix = "<Leader>j"
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
        maps.n[prefix] = { desc = " Jupynium" }
        maps.v[prefix] = { desc = " Jupynium" }
        maps.n[prefix .. "s"] = {
          "<cmd>JupyniumStartAndAttachToServer<CR>",
          desc = "Jupynium start and attach to server",
        }
        maps.n[prefix .. "S"] = {
          "<cmd>JupyniumStopSync<CR>",
          desc = "Jupynium start and attach to server",
        }

        maps.n[prefix .. "d"] = {
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

        maps.n[prefix .. "r"] = {
          "<cmd>JupyniumExecuteSelectedCells<CR>",
          desc = "Jupynium execute selected cells",
        }
        maps.x[prefix .. "r"] = maps.n[prefix .. "r"]

        maps.n[prefix .. "c"] = {
          "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
          desc = "Jupynium clear selected cells",
        }
        maps.x[prefix .. "c"] = maps.n[prefix .. "c"]

        maps.n[prefix .. "h"] = {
          "<cmd>JupyniumKernelHover<cr>",
          desc = "Jupynium hover (inspect a variable)",
        }

        maps.n[prefix .. "x"] = {
          "<cmd>JupyniumScrollToCell<cr>",
          desc = "Jupynium scroll to cell",
        }
        maps.x[prefix .. "x"] = maps.n[prefix .. "x"]

        maps.n[prefix .. "t"] = {
          "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
          desc = "Jupynium toggle selected cell output scroll",
        }
        maps.x[prefix .. "t"] = maps.n[prefix .. "t"]

        maps.n[prefix .. "k"] = {
          "<cmd>JupyniumScrollUp<cr>",
          desc = "Jupynium scroll up",
        }

        maps.n[prefix .. "j"] = {
          "<cmd>JupyniumScrollDown<cr>",
          desc = "Jupynium scroll down",
        }
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
      textobjects = {
        use_default_keybindings = false,
      },
    },
    build = "pip install --user .",
  },
}
