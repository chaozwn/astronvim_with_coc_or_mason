return {
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufEnter",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        load_breakpoints_event = { "BufEnter" },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open { layout = 2, reset = true }
      end
      dapui.setup(opts)
    end,
  },
}
