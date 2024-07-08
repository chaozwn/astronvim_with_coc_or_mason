return {
  "Zeioth/compiler.nvim",
  dependencies = {
    {
      "stevearc/overseer.nvim",
      cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerSaveBundle",
        "OverseerLoadBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerRun",
        "OverseerInfo",
        "OverseerBuild",
        "OverseerQuickAction",
        "OverseerTaskAction ",
        "OverseerClearCache",
      },
      ---@param opts overseer.Config
      config = function(_, opts)
        if not opts then opts = {} end
        local overseer = require "overseer"
        local astrocore = require "astrocore"
        if astrocore.is_available "toggleterm.nvim" then opts.strategy = "toggleterm" end

        overseer.setup(astrocore.extend_tbl(opts, {
          dap = false,
          templates = { "user.run_python", "user.run_goctl_api" },
          direction = "bottom",
          bindings = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
            q = "<Cmd>close<CR>",
            K = "IncreaseDetail",
            J = "DecreaseDetail",
            ["<C-p>"] = "ScrollOutputUp",
            ["<C-n>"] = "ScrollOutputDown",
          },
        }))
      end,
      dependencies = {
        { "AstroNvim/astroui", opts = { icons = { Overseer = "" } } },
        {
          "AstroNvim/astrocore",
          opts = function(_, opts)
            local maps = opts.mappings
            local prefix = "<leader>M"
            maps.n[prefix] = { desc = require("astroui").get_icon("Overseer", 1, true) .. "Overseer" }

            maps.n[prefix .. "t"] = { "<Cmd>OverseerToggle<CR>", desc = "Toggle Overseer" }
            maps.n[prefix .. "c"] = { "<Cmd>OverseerRunCmd<CR>", desc = "Run Command" }
            maps.n[prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run Task" }
            maps.n[prefix .. "q"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" }
            maps.n[prefix .. "a"] = { "<Cmd>OverseerTaskAction<CR>", desc = "Task Action" }
            maps.n[prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" }
          end,
        },
      },
    },
  },
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  opts = {},
}
