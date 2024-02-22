local utils = require "astrocore"
local prefix = "<Leader>fd"
return {
  { "jay-babu/mason-nvim-dap.nvim", optional = true, init = false },
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
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "LiadOz/nvim-dap-repl-highlights",
      dependencies = { "mfussenegger/nvim-dap" },
      opts = {},
    },
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "dap_repl" })
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    opts = {
      commented = true,
      enabled = true,
      enabled_commands = true,
    },
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
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { prefix .. "c", function() require("telescope").extensions.dap.commands() end, desc = "Telescope DAP commands" },
      { prefix .. "f", function() require("telescope").extensions.dap.frames() end, desc = "Telescope DAP frames" },
      {
        prefix .. "g",
        function() require("telescope").extensions.dap.configurations() end,
        desc = "Telescope DAP configurations",
      },
      {
        prefix .. "l",
        function() require("telescope").extensions.dap.list_breakpoints() end,
        desc = "Telescope DAP list breakpoints",
      },
      {
        prefix .. "v",
        function() require("telescope").extensions.dap.variables() end,
        desc = "Telescope DAP variables",
      },
    },
    dependencies = { "nvim-telescope/telescope-dap.nvim" },
    opts = function() require("telescope").load_extension "dap" end,
  },
}
